param (
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $CommunicationServiceName,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $CommunicationServiceResourceGroup,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $EmailFrom
)

function InitializeCommunicationServicePackages {
    [CmdletBinding()]
    param ()

    $commPackagesDirName = "CommunicationServicePackages"
    $commPackagesDir = Join-Path -Path . -ChildPath $commPackagesDirName
    if (Test-Path -LiteralPath $commPackagesDir) {
        Remove-Item -Path $commPackagesDir -Recurse -Force
    }

    New-Item -Path . -Name $commPackagesDirName -ItemType Directory -Force

    $commPackages = @(
        @{ PackageName = "Azure.Communication.Email"; PackageVersion = "1.0.0"; DllName = "Azure.Communication.dll" },
        @{ PackageName = "Azure.Core"; PackageVersion = "1.30.0"; DllName = "Azure.Core.dll" },
        @{ PackageName = "System.Memory.Data"; PackageVersion = "1.0.2"; DllName = "System.Memory.Data.dll" }
    )

    $commPackages | ForEach-Object {
        $packageName = $_["PackageName"]
        $packageVersion = $_["PackageVersion"]
        $packageDll = $_["DllName"]
        Install-Package -Name $packageName -RequiredVersion $packageVersion -Source "https://www.nuget.org/api/v2" -Destination $kustoPackagesDirectory -SkipDependencies -ExcludeVersion -Force
        Add-Type -LiteralPath (Join-Path -Path $kustoPackagesDirectory -ChildPath $packageName | Join-Path -ChildPath "lib" | Join-Path -ChildPath "netstandard2.0" | Join-Path -ChildPath $packageDll)
    }
}

function Send-CommunicationServiceEmail {
    param(
        [Parameter(Mandatory)]
        [string]$To,

        [Parameter(Mandatory)]
        [string]$Subject,

        [Parameter(Mandatory=$true)]
        [string]$Body
    )

    $conn = Get-AzCommunicationServiceKey -CommunicationServiceName $CommunicationServiceName -ResourceGroupName $CommunicationServiceResourceGroup | Select-Object -ExpandProperty PrimaryConnectionString
    $emailClient = [Azure.Communication.Email.EmailClient]::new($conn)

    Write-Host "Sending email..."
    $emailClient.SendAsync([Azure.WaitUntil]::Completed, $EmailFrom, $To, $Subject, $Body).GetAwaiter().GetResult()
    Write-Host "Finished sending email."
}

InitializeCommunicationServicePackages
