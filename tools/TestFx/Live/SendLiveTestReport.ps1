param (
    [Parameter(Mandatory, Position = 0)]
    [ValidateNotNullOrEmpty()]
    [guid] $ServicePrincipalTenantId,

    [Parameter(Mandatory, Position = 1)]
    [ValidateNotNullOrEmpty()]
    [guid] $ServicePrincipalId,

    [Parameter(Mandatory, Position = 2)]
    [ValidateNotNullOrEmpty()]
    [string] $ServicePrincipalSecret,

    [Parameter(Mandatory, Position = 3)]
    [ValidateNotNullOrEmpty()]
    [string] $ClusterName,

    [Parameter(Mandatory, Position = 4)]
    [ValidateNotNullOrEmpty()]
    [string] $ClusterRegion,

    [Parameter(Mandatory, Position = 5)]
    [ValidateNotNullOrEmpty()]
    [string] $DatabaseName,

    [Parameter(Mandatory, Position = 6)]
    [ValidateNotNullOrEmpty()]
    [string] $TableName,

    [Parameter(Mandatory, Position = 7)]
    [ValidateNotNullOrEmpty()]
    [string] $BuildId,

    [Parameter(Mandatory, Position = 8)]
    [ValidateNotNullOrEmpty()]
    [string] $CommunicationServiceName,

    [Parameter(Mandatory, Position = 9)]
    [ValidateNotNullOrEmpty()]
    [string] $CommunicationServiceResourceGroup,

    [Parameter(Mandatory, Position = 10)]
    [ValidateNotNullOrEmpty()]
    [string] $EmailFrom,

    [Parameter(Mandatory, Position = 11)]
    [ValidateNotNullOrEmpty()]
    [string] $EmailTo
)

$utilDir = Join-Path -Path ($PSScriptRoot | Split-Path) -ChildPath "Utilities"

$kustoUtil = $utilDir | Join-Path -ChildPath "KustoUtility.psd1"
Import-Module $kustoUtil -ArgumentList $ServicePrincipalTenantId, $ServicePrincipalId, $ServicePrincipalSecret, $ClusterName, $ClusterRegion -Force

$query = @"
    $TableName
    | where BuildId == $BuildId and IsSuccess == false
    | project OSVersion, PSVersion, Module, Name, Exception = tostring(Errors["Exception"]), RetryException = tostring(Errors["Retry3Exception"])
"@
$errors = Get-KustoQueryData -DatabaseName $DatabaseName -Query $query

$commSvcUtil = $utilDir | Join-Path -ChildPath "CommunicationServiceUtility.psd1"
Import-Module $commSvcUtil -ArgumentList $CommunicationServiceName, $CommunicationServiceResourceGroup, $EmailFrom -Force

$emailSubject = "Live Test Status Report"
$emailBody = "<html><body>$reportContent</body></html>"
if ($errors.Count -gt 0) {
    $reportContent = "<h1>Live Test Error Details</h1><br/>$($errors | ConvertTo-Html -As Table -Fragment)"
}
else {
    $reportContent = "<h1>No live test errors reported. Please check the overall status from Azure pipeline.</h1>"
}

Send-CommunicationServiceEmail -To $EmailTo -Subject $emailSubject -Body $emailBody
