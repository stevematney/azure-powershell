﻿// ----------------------------------------------------------------------------------
//
// Copyright Microsoft Corporation
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// ----------------------------------------------------------------------------------

using Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters;
using System.Management.Automation;
using Microsoft.WindowsAzure.Commands.Common.CustomAttributes;


namespace Microsoft.Azure.Commands.ContainerRegistry
{
    [Cmdlet("Remove", ResourceManager.Common.AzureRMConstants.AzureRMPrefix + "ContainerRegistry", DefaultParameterSetName = NameResourceGroupParameterSet, SupportsShouldProcess = true)]
    [OutputType(typeof(bool))]
    public class RemoveAzureContainerRegistry : ContainerRegistryCmdletBase
    {
        [Parameter(Position = 0, Mandatory = true, ParameterSetName = NameResourceGroupParameterSet, HelpMessage = "Resource Group Name.")]
        [ResourceGroupCompleter()]
        [ValidateNotNullOrEmpty]
        public string ResourceGroupName { get; set; }

        [Parameter(Position = 1, Mandatory = true, ParameterSetName = NameResourceGroupParameterSet, HelpMessage = "Container Registry Name.")]
        [Alias(ContainerRegistryNameAlias, RegistryNameAlias, ResourceNameAlias)]
        [ValidateNotNullOrEmpty]
        public string Name { get; set; }

        [Parameter(Mandatory = true, ParameterSetName = RegistryObjectParameterSet, HelpMessage = "Container Registry Object.")]
        [ValidateNotNull]
        public PSContainerRegistry Registry { get; set; }
        
        public const string ChangeDesc = "Parameter is being deprecated without being replaced"; 
        [CmdletParameterBreakingChange("ResourceId", "4.0.0.0", "05/23/2023", ChangeDescription = ChangeDesc)]
        [Parameter(Mandatory = true, ParameterSetName = ResourceIdParameterSet, ValueFromPipelineByPropertyName = true, HelpMessage = "The container registry resource id")]
        [ValidateNotNullOrEmpty]
        [Alias(ResourceIdAlias)]
        public string ResourceId { get; set; }

        [Parameter(Mandatory = false)]
        public SwitchParameter PassThru { get; set; }

        public override void ExecuteCmdlet()
        {
            if (string.Equals(ParameterSetName, RegistryObjectParameterSet))
            {
                ResourceGroupName = Registry.ResourceGroupName;
                Name = Registry.Name;
            }
            else if (MyInvocation.BoundParameters.ContainsKey("ResourceId") || !string.IsNullOrWhiteSpace(ResourceId))
            {
                string resourceGroup, registryName, childResourceName;
                if (!ConversionUtilities.TryParseRegistryRelatedResourceId(ResourceId, out resourceGroup, out registryName, out childResourceName))
                {
                    WriteInvalidResourceIdError(InvalidRegistryResourceIdErrorMessage);
                    return;
                }

                ResourceGroupName = resourceGroup;
                Name = registryName;
            }

            if (ShouldProcess(Name, "Remove Container Registry"))
            {
                RegistryClient.DeleteRegistry(ResourceGroupName, Name);
                if (PassThru)
                {
                    WriteObject(true);
                }
            }
        }
    }
}
