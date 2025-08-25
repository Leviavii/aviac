# AppService-010 - App Service Authentication Test

## Purpose
This Bicep template intentionally **FAILS** the AppService-010 rego rule to validate the scanning pipeline.

## Rego Rule: AppService-010
**File**: `ensure_app_service_authentication_is_set_on_azure_app_service/query.rego`

**Rule checks for**:
- Resource type: `Microsoft.Web/sites/config`
- Resource name: `authsettings`
- Required: `properties.enabled = true`

## Intentional Failure
This template creates a Web App **WITHOUT** the required `authsettings` configuration resource.

### Expected ARM Output (after compilation):
```json
{
  "type": "Microsoft.Web/sites",
  "name": "webapp-test-xyz",
  "properties": {
    "serverFarmId": "...",
    "httpsOnly": true
  }
  // ❌ MISSING: Microsoft.Web/sites/config with name "authsettings"
}
```

### Rego Rule Trigger:
1. Rego scans for `Microsoft.Web/sites/config` with name `authsettings`
2. **Finds**: Web App exists but authsettings config is missing
3. **Result**: `result := "fail"` - MissingAttribute
4. **Issue appears in Wiz portal**: "App Service Authentication properties are not defined"

## Validation
If you see this finding in Wiz portal, it confirms:
- ✅ Bicep-to-ARM compilation works  
- ✅ Rego rule scanning works
- ✅ Issue reporting works

## Files
- `main.bicep` - Main deployment template
- `modules/webapp.bicep` - Web App module (missing authsettings)
- `main.bicepparam` - Parameter file
