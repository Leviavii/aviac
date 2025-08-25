# StorageAccount-013 - Blob Container Public Access Test

## Purpose
This Bicep template intentionally **FAILS** the StorageAccount-013 rego rule to validate the scanning pipeline.

## Rego Rule: StorageAccount-013
**File**: `ensure_that__public_access_level__is_set_to_private_for_blob_containers/query.rego`

**Rule checks for**:
- Resource type: `Microsoft.Storage/storageAccounts/blobServices/containers`
- Fails when: `properties.publicAccess` is "container" or "blob"
- Required: `publicAccess` should be "None" (private)

## Intentional Failure
This template creates a blob container with `publicAccess: 'Container'` instead of `'None'`.

### Expected ARM Output (after compilation):
```json
{
  "type": "Microsoft.Storage/storageAccounts/blobServices/containers",
  "name": "ststoragetest/default/public-test-container",
  "properties": {
    "publicAccess": "Container",  // ❌ FAILS: Should be "None" 
    "metadata": {
      "purpose": "rego-rule-testing",
      "rule": "StorageAccount-013"
    }
  }
}
```

### Rego Rule Trigger:
1. Rego scans for `Microsoft.Storage/storageAccounts/blobServices/containers`
2. **Finds**: `properties.publicAccess: "Container"`
3. **Condition**: `lower(publicAccess) == "container"` (matches forbidden value)
4. **Result**: `result := "fail"` - IncorrectValue  
5. **Issue appears in Wiz portal**: "publicAccess should be set to 'None'"

## Validation
If you see this finding in Wiz portal, it confirms:
- ✅ Bicep-to-ARM compilation works
- ✅ Rego rule scanning works
- ✅ Issue reporting works

## Files
- `main.bicep` - Main deployment template
- `modules/storage.bicep` - Storage account module
- `modules/container.bicep` - Container module (with public access enabled)
- `main.bicepparam` - Parameter file
