targetScope = 'managementGroup'
resource denySQLPublicAccess 'Microsoft.Authorization/policyDefinitions@2018-05-01' = {
  name: 'denySQLPublicAccess'
  properties: {
    policyType: 'Custom'
    mode: 'All'
    displayName: 'Deny SQL Server Database Public Access'
    description: 'Prevents SQL Server Database Public Access'
    parameters: null
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Sql/servers'
          }
          {
            field: 'Microsoft.Sql/servers/publicNetworkAccess'
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