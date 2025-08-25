# Aviac - Rego Rule Validation Templates

This repository contains intentionally misconfigured Bicep templates designed to validate the ARM→Rego scanning pipeline.

## Purpose
These templates create Azure resources with specific security misconfigurations that should trigger corresponding rego rules in the Wiz scanning system. If findings appear in the Wiz portal, it confirms the entire pipeline is working:

1. ✅ Bicep templates compile to ARM correctly
2. ✅ Rego rules scan ARM templates successfully  
3. ✅ Security findings are reported to Wiz portal

## Test Rules

### 🔴 AppService-010 - App Service Authentication
**Intentional Failure**: Web App deployed without `authsettings` configuration
- **Expected Finding**: "App Service Authentication properties are not defined"
- **Rego Check**: Missing `Microsoft.Web/sites/config` with name "authsettings"

### 🔴 DatabaseServer-001 - Redis Public Network Access  
**Intentional Failure**: Redis Cache with `publicNetworkAccess: 'Enabled'`
- **Expected Finding**: "publicNetworkAccess should be set to 'Disabled'"
- **Rego Check**: `Microsoft.Cache/redis` with public access enabled

### 🔴 StorageAccount-013 - Blob Container Public Access
**Intentional Failure**: Blob container with `publicAccess: 'Container'`  
- **Expected Finding**: "publicAccess should be set to 'None'"
- **Rego Check**: `Microsoft.Storage/.../containers` with public access enabled

## Repository Structure

```
AppService-010/
├── main.bicep                    # Main deployment
├── modules/webapp.bicep          # Web App (missing authsettings)
├── main.bicepparam              # Parameters  
└── README.md                     # Detailed explanation

DatabaseServer-001/
├── main.bicep                    # Main deployment
├── modules/redis.bicep           # Redis (public access enabled)
├── main.bicepparam              # Parameters
└── README.md                     # Detailed explanation

StorageAccount-013/  
├── main.bicep                    # Main deployment
├── modules/storage.bicep         # Storage account
├── modules/container.bicep       # Container (public access enabled)
├── main.bicepparam              # Parameters
└── README.md                     # Detailed explanation
```

## Usage
Deploy any of these templates to your Azure environment. The resulting ARM templates will contain the specific misconfigurations that should trigger the corresponding rego rules.

**⚠️ Warning**: These templates create intentionally insecure configurations for testing purposes only. Do not use in production environments.