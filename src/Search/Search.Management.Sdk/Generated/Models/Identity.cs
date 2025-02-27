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
    using Newtonsoft.Json;
    using System.Linq;

    /// <summary>
    /// Identity for the resource.
    /// </summary>
    public partial class Identity
    {
        /// <summary>
        /// Initializes a new instance of the Identity class.
        /// </summary>
        public Identity()
        {
            CustomInit();
        }

        /// <summary>
        /// Initializes a new instance of the Identity class.
        /// </summary>
        /// <param name="type">The identity type. Possible values include:
        /// 'None', 'SystemAssigned'</param>
        /// <param name="principalId">The principal ID of the system-assigned
        /// identity of the search service.</param>
        /// <param name="tenantId">The tenant ID of the system-assigned
        /// identity of the search service.</param>
        public Identity(IdentityType type, string principalId = default(string), string tenantId = default(string))
        {
            PrincipalId = principalId;
            TenantId = tenantId;
            Type = type;
            CustomInit();
        }

        /// <summary>
        /// An initialization method that performs custom operations like setting defaults
        /// </summary>
        partial void CustomInit();

        /// <summary>
        /// Gets the principal ID of the system-assigned identity of the search
        /// service.
        /// </summary>
        [JsonProperty(PropertyName = "principalId")]
        public string PrincipalId { get; private set; }

        /// <summary>
        /// Gets the tenant ID of the system-assigned identity of the search
        /// service.
        /// </summary>
        [JsonProperty(PropertyName = "tenantId")]
        public string TenantId { get; private set; }

        /// <summary>
        /// Gets or sets the identity type. Possible values include: 'None',
        /// 'SystemAssigned'
        /// </summary>
        [JsonProperty(PropertyName = "type")]
        public IdentityType Type { get; set; }

        /// <summary>
        /// Validate the object.
        /// </summary>
        /// <exception cref="Rest.ValidationException">
        /// Thrown if validation fails
        /// </exception>
        public virtual void Validate()
        {
        }
    }
}
