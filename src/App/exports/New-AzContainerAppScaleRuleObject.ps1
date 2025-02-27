
# ----------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# Code generated by Microsoft (R) AutoRest Code Generator.Changes may cause incorrect behavior and will be lost if the code
# is regenerated.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Create an in-memory object for ScaleRule.
.Description
Create an in-memory object for ScaleRule.
.Example
$scaleRule = @()
$scaleRule += New-AzContainerAppScaleRuleObject -Name scaleRuleName1 -AzureQueueLength 30 -AzureQueueName azps_containerapp -CustomType "azure-servicebus"
$scaleRule += New-AzContainerAppScaleRuleObject -Name scaleRuleName2 -AzureQueueLength 30 -AzureQueueName azps_containerapp -CustomType "azure-servicebus"

.Outputs
Microsoft.Azure.PowerShell.Cmdlets.App.Models.Api20220301.ScaleRule
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

AZUREQUEUEAUTH <IScaleRuleAuth[]>: Authentication secrets for the queue scale rule.
  [SecretRef <String>]: Name of the Container App secret from which to pull the auth params.
  [TriggerParameter <String>]: Trigger Parameter that uses the secret

CUSTOMAUTH <IScaleRuleAuth[]>: Authentication secrets for the custom scale rule.
  [SecretRef <String>]: Name of the Container App secret from which to pull the auth params.
  [TriggerParameter <String>]: Trigger Parameter that uses the secret

CUSTOMMETADATA <ICustomScaleRuleMetadata>: Metadata properties to describe custom scale rule.
  [(Any) <String>]: This indicates any property can be added to this object.

HTTPAUTH <IScaleRuleAuth[]>: Authentication secrets for the custom scale rule.
  [SecretRef <String>]: Name of the Container App secret from which to pull the auth params.
  [TriggerParameter <String>]: Trigger Parameter that uses the secret

HTTPMETADATA <IHttpScaleRuleMetadata>: Metadata properties to describe http scale rule.
  [(Any) <String>]: This indicates any property can be added to this object.
.Link
https://learn.microsoft.com/powershell/module/az./new-azcontainerappscaleruleobject
#>
function New-AzContainerAppScaleRuleObject {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.App.Models.Api20220301.ScaleRule])]
[CmdletBinding(PositionalBinding=$false)]
param(
    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.App.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.App.Models.Api20220301.IScaleRuleAuth[]]
    # Authentication secrets for the queue scale rule.
    # To construct, see NOTES section for AZUREQUEUEAUTH properties and create a hash table.
    ${AzureQueueAuth},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.App.Category('Body')]
    [System.Int32]
    # Queue length.
    ${AzureQueueLength},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.App.Category('Body')]
    [System.String]
    # Queue name.
    ${AzureQueueName},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.App.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.App.Models.Api20220301.IScaleRuleAuth[]]
    # Authentication secrets for the custom scale rule.
    # To construct, see NOTES section for CUSTOMAUTH properties and create a hash table.
    ${CustomAuth},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.App.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.App.Models.Api20220301.ICustomScaleRuleMetadata]
    # Metadata properties to describe custom scale rule.
    # To construct, see NOTES section for CUSTOMMETADATA properties and create a hash table.
    ${CustomMetadata},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.App.Category('Body')]
    [System.String]
    # Type of the custom scale rule
    #         eg: azure-servicebus, redis etc.
    ${CustomType},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.App.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.App.Models.Api20220301.IScaleRuleAuth[]]
    # Authentication secrets for the custom scale rule.
    # To construct, see NOTES section for HTTPAUTH properties and create a hash table.
    ${HttpAuth},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.App.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.App.Models.Api20220301.IHttpScaleRuleMetadata]
    # Metadata properties to describe http scale rule.
    # To construct, see NOTES section for HTTPMETADATA properties and create a hash table.
    ${HttpMetadata},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.App.Category('Body')]
    [System.String]
    # Scale Rule Name.
    ${Name}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName

        if ($null -eq [Microsoft.WindowsAzure.Commands.Utilities.Common.AzurePSCmdlet]::PowerShellVersion) {
            [Microsoft.WindowsAzure.Commands.Utilities.Common.AzurePSCmdlet]::PowerShellVersion = $Host.Version.ToString()
        }         
        $preTelemetryId = [Microsoft.WindowsAzure.Commands.Common.MetricHelper]::TelemetryId
        if ($preTelemetryId -eq '') {
            [Microsoft.WindowsAzure.Commands.Common.MetricHelper]::TelemetryId =(New-Guid).ToString()
            [Microsoft.Azure.PowerShell.Cmdlets.App.module]::Instance.Telemetry.Invoke('Create', $MyInvocation, $parameterSet, $PSCmdlet)
        } else {
            $internalCalledCmdlets = [Microsoft.WindowsAzure.Commands.Common.MetricHelper]::InternalCalledCmdlets
            if ($internalCalledCmdlets -eq '') {
                [Microsoft.WindowsAzure.Commands.Common.MetricHelper]::InternalCalledCmdlets = $MyInvocation.MyCommand.Name
            } else {
                [Microsoft.WindowsAzure.Commands.Common.MetricHelper]::InternalCalledCmdlets += ',' + $MyInvocation.MyCommand.Name
            }
            [Microsoft.WindowsAzure.Commands.Common.MetricHelper]::TelemetryId = 'internal'
        }

        $mapping = @{
            __AllParameterSets = 'Az.App.custom\New-AzContainerAppScaleRuleObject';
        }
        $cmdInfo = Get-Command -Name $mapping[$parameterSet]
        [Microsoft.Azure.PowerShell.Cmdlets.App.Runtime.MessageAttributeHelper]::ProcessCustomAttributesAtRuntime($cmdInfo, $MyInvocation, $parameterSet, $PSCmdlet)
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        [Microsoft.WindowsAzure.Commands.Common.MetricHelper]::ClearTelemetryContext()
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        [Microsoft.WindowsAzure.Commands.Common.MetricHelper]::ClearTelemetryContext()
        throw
    }

    finally {
        $backupTelemetryId = [Microsoft.WindowsAzure.Commands.Common.MetricHelper]::TelemetryId
        $backupInternalCalledCmdlets = [Microsoft.WindowsAzure.Commands.Common.MetricHelper]::InternalCalledCmdlets
        [Microsoft.WindowsAzure.Commands.Common.MetricHelper]::ClearTelemetryContext()
    }

}
end {
    try {
        $steppablePipeline.End()

        [Microsoft.WindowsAzure.Commands.Common.MetricHelper]::TelemetryId = $backupTelemetryId
        [Microsoft.WindowsAzure.Commands.Common.MetricHelper]::InternalCalledCmdlets = $backupInternalCalledCmdlets
        if ($preTelemetryId -eq '') {
            [Microsoft.Azure.PowerShell.Cmdlets.App.module]::Instance.Telemetry.Invoke('Send', $MyInvocation, $parameterSet, $PSCmdlet)
            [Microsoft.WindowsAzure.Commands.Common.MetricHelper]::ClearTelemetryContext()
        }
        [Microsoft.WindowsAzure.Commands.Common.MetricHelper]::TelemetryId = $preTelemetryId

    } catch {
        [Microsoft.WindowsAzure.Commands.Common.MetricHelper]::ClearTelemetryContext()
        throw
    }
} 
}
