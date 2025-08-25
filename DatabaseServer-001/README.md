# DatabaseServer-001 - Redis Public Network Access Test

## Purpose
This Bicep template intentionally **FAILS** the DatabaseServer-001 rego rule to validate the scanning pipeline.

## Rego Rule: DatabaseServer-001
**File**: `ensure_that_azure_cache_for_redis_disables_public_network_access/query.rego`

**Rule checks for**:
- Resource type: `Microsoft.Cache/redis`
- Required: `properties.publicNetworkAccess = "Disabled"`
- Fails when: `publicNetworkAccess` is NOT "Disabled"

## Intentional Failure
This template creates a Redis Cache with `publicNetworkAccess: 'Enabled'` instead of `'Disabled'`.

### Expected ARM Output (after compilation):
```json
{
  "type": "Microsoft.Cache/redis",
  "name": "redis-test-xyz", 
  "properties": {
    "sku": {
      "name": "Basic",
      "family": "C",
      "capacity": 0
    },
    "publicNetworkAccess": "Enabled",  // ❌ FAILS: Should be "Disabled"
    "minimumTlsVersion": "1.2"
  }
}
```

### Rego Rule Trigger:
1. Rego scans for `Microsoft.Cache/redis` resources
2. **Finds**: `publicNetworkAccess: "Enabled"` 
3. **Condition**: `not lower(publicNetworkAccess) == "disabled"`
4. **Result**: `result := "fail"` - IncorrectValue
5. **Issue appears in Wiz portal**: "publicNetworkAccess should be set to 'Disabled'"

## Validation
If you see this finding in Wiz portal, it confirms:
- ✅ Bicep-to-ARM compilation works
- ✅ Rego rule scanning works  
- ✅ Issue reporting works

## Files
- `main.bicep` - Main deployment template
- `modules/redis.bicep` - Redis module (with public access enabled)
- `main.bicepparam` - Parameter file
