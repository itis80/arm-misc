targetScope = 'managementGroup'
resource denyStorageAccountPublicAccess 'Microsoft.Authorization/policyDefinitions@2018-05-01' = {
  name: 'denyStorageAccountPublicAccess'
  properties: {
    policyType: 'Custom'
    mode: 'All'
    displayName: 'Deny Storage Account Public Access'
    description: 'Prevents Storage Account Public Access'
    parameters: null
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Storage/storageAccounts'
          }
          {
            field: 'Microsoft.Storage/storageAccounts/networkAcls.defaultAction'
            notequals: 'Deny'
          }
        ]
      }
      then: {
        effect: 'Deny'
      }
    }
  }
}