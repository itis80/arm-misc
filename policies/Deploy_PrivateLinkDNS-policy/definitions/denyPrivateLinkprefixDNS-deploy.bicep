targetScope = 'managementGroup'
resource denyprivatelinkdnszone 'Microsoft.Authorization/policyDefinitions@2018-05-01' = {
  name: 'denyprivatelinkdnszone'
  properties: {
    policyType: 'Custom'
    mode: 'All'
    displayName: 'Deny PrivateDNSZone PrivateLink'
    description: 'Prevents creation of privatelink Private Dns zones'
    parameters: null
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Network/privateDnsZones'
          }
          {
            field: 'name'
            like: 'privatelink*'
          }
        ]
      }
      then: {
        effect: 'Deny'
      }
    }
  }
}