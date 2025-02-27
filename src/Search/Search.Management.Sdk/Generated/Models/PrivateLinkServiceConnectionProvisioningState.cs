// <auto-generated>
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for
// license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
// Changes may cause incorrect behavior and will be lost if the code is
// regenerated.
// </auto-generated>

namespace Microsoft.Azure.Management.Search.Models
{

    /// <summary>
    /// Defines values for PrivateLinkServiceConnectionProvisioningState.
    /// </summary>
    public static class PrivateLinkServiceConnectionProvisioningState
    {
        /// <summary>
        /// The private link service connection is in the process of being
        /// created along with other resources for it to be fully functional.
        /// </summary>
        public const string Updating = "Updating";
        /// <summary>
        /// The private link service connection is in the process of being
        /// deleted.
        /// </summary>
        public const string Deleting = "Deleting";
        /// <summary>
        /// The private link service connection has failed to be provisioned or
        /// deleted.
        /// </summary>
        public const string Failed = "Failed";
        /// <summary>
        /// The private link service connection has finished provisioning and
        /// is ready for approval.
        /// </summary>
        public const string Succeeded = "Succeeded";
        /// <summary>
        /// Provisioning request for the private link service connection
        /// resource has been accepted but the process of creation has not
        /// commenced yet.
        /// </summary>
        public const string Incomplete = "Incomplete";
        /// <summary>
        /// Provisioning request for the private link service connection
        /// resource has been canceled
        /// </summary>
        public const string Canceled = "Canceled";
    }
}
