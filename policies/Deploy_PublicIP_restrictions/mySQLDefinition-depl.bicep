targetScope = 'managementGroup'
resource denyMySQLPublicAccess 'Microsoft.Authorization/policyDefinitions@2018-05-01' = {
  name: 'denyMySQLPublicAccess'
  properties: {
    policyType: 'Custom'
    mode: 'All'
    displayName: 'Deny MySQL Database Public Access'
    description: 'Prevents MySQL Database Public Access'
    parameters: null
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.DBforMySQL/servers'
          }
          {
            field: 'Microsoft.DBforMySQL/servers/publicNetworkAccess'
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