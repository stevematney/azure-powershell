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
    [string] $BuildId
)

$kustoUtil = Join-Path -Path ($PSScriptRoot | Split-Path) -ChildPath "Utilities" | Join-Path -ChildPath "KustoUtility.psd1"
Import-Module $kustoUtil -ArgumentList $ServicePrincipalTenantId, $ServicePrincipalId, $ServicePrincipalSecret, $ClusterName, $ClusterRegion -Force

$query = @"
    $TableName
    | where BuildId == $BuildId and IsSuccess == false
    | project OSVersion, PSVersion, Module, Name, Exception = tostring(Errors["Exception"]), RetryException = tostring(Errors["Retry3Exception"])
"@
$errors = Get-KustoQueryData -DatabaseName $DatabaseName -Query $query

if ($errors.Count -gt 0) {
    $reportContent = "<h1>Live Test Error Details</h1><br/>$($errors | ConvertTo-Html -As Table -Fragment)"
}
else {
    $reportContent = "<h1>All live tests have been executed successfully</h1>"
}

$conn = Get-AzCommunicationServiceKey -CommunicationServiceName LiveTestCommunicationServices -ResourceGroupName AzurePowerShellLiveTest | Select-Object -ExpandProperty PrimaryConnectionString
$emailClient = [Azure.Communication.Email.EmailClient]::new($conn)
$subject = "Live Test Status Report"
$body = "<html><body>$reportContent</body></html>"
$from = "DoNotReply@4895130f-75dd-4732-969e-d89aaa072808.azurecomm.net"
$to = "vidai@microsoft.com"

Write-Host "Sending email..."
$emailClient.SendAsync([Azure.WaitUntil]::Completed, $from, $to, $subject, $body).GetAwaiter().GetResult()
Write-Host "Finished sending email."
