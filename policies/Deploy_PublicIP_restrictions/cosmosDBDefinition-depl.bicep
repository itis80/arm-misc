targetScope = 'managementGroup'
resource denycosmosDBPublicAccess 'Microsoft.Authorization/policyDefinitions@2018-05-01' = {
  name: 'denycosmosDBPublicAccess'
  properties: {
    policyType: 'Custom'
    mode: 'All'
    displayName: 'Deny CosmosDB Server Database Public Access'
    description: 'Prevents CosmosDB Server Database Public Access'
    parameters: null
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.DocumentDB/databaseAccounts'
          }
          {
            field: 'Microsoft.DocumentDB/databaseAccounts/publicNetworkAccess'
            notequals: 'Disabled'
          }
        ]
      }
      then: {
        effect: 'Deny'
      }
    }
  }
}