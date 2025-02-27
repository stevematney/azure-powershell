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

using Microsoft.Azure.Management.ContainerRegistry.Models;
using System.Management.Automation;
using Microsoft.WindowsAzure.Commands.Common.CustomAttributes;


namespace Microsoft.Azure.Commands.ContainerRegistry
{
    [GenericBreakingChange("The Az.ContainerRegistry module is upgrading. The output properties may have some changes", "4.0.0.0")]
    [Cmdlet("Test", ResourceManager.Common.AzureRMConstants.AzureRMPrefix + "ContainerRegistryNameAvailability")]
    [OutputType(typeof(RegistryNameStatus))]
    public class TestAzureContainerRegistryNameAvailability : ContainerRegistryCmdletBase
    {
        [Parameter(Position = 0, Mandatory = true, ValueFromPipelineByPropertyName = true, HelpMessage = "Container Registry Name.")]
        [Alias(ContainerRegistryNameAlias, RegistryNameAlias, ResourceNameAlias)]
        [ValidateNotNullOrEmpty]
        public string Name { get; set; }

        public override void ExecuteCmdlet()
        {
            WriteObject(RegistryClient.CheckRegistryNameAvailability(Name));
        }
    }
}
