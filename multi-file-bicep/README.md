# Multi-File Bicep Scenarios

This folder contains examples of Bicep deployments that span multiple files - a common result when ARM templates are converted to Bicep using modularization.

## File Structure

```
9_multi_file_scenarios/
├── main_orchestration/       ← Main + modules scenario
│   ├── main.bicep           ← Main orchestration file
│   ├── storage.bicep        ← Storage module
│   ├── networking.bicep     ← Networking module  
│   ├── application.bicep    ← Application module
│   └── rbac.bicep          ← RBAC/Security module
├── nested_deployment/       ← Nested deployment scenario
│   ├── nested_deployment.bicep ← Nested deployment pattern
│   ├── nested_storage.bicep    ← Nested storage module
│   ├── nested_compute.bicep    ← Nested compute module
│   └── nested_rbac.bicep       ← Nested RBAC module
├── guid_scenario/           ← GUID-based deployment
│   └── guid.bicep          
├── generic_module/          ← Generic module scenario
│   └── module.bicep        
└── README.md               ← This documentation
```

## Scenarios Covered

### 1. **Main + Modules Pattern** (`main_orchestration/`)
**Purpose**: Shows how complex ARM templates get decomposed into modular Bicep files
**Files**: `main.bicep`, `storage.bicep`, `networking.bicep`, `application.bicep`, `rbac.bicep`
**Usage**: Parse all files in this directory together to understand complete infrastructure
**Build Command**: `az bicep build --file main_orchestration/main.bicep`

### 2. **Nested Deployment Pattern** (`nested_deployment/`)
**Purpose**: Shows ARM nested deployments converted to Bicep modules
**Files**: `nested_deployment.bicep`, `nested_storage.bicep`, `nested_compute.bicep`, `nested_rbac.bicep`
**Common in**: Complex enterprise deployments with layered dependencies
**Build Command**: `az bicep build --file nested_deployment/nested_deployment.bicep`

### 3. **GUID-based Deployment** (`guid_scenario/`)
**Purpose**: Demonstrates ARM templates with GUID functions converted to Bicep
**Files**: `guid.bicep` (standalone)
**Common in**: Role assignments, resource naming, deployment tracking
**Build Command**: `az bicep build --file guid_scenario/guid.bicep`

### 4. **Generic Module** (`generic_module/`)
**Purpose**: Represents common "module.bicep" files created during ARM conversion
**Files**: `module.bicep` (standalone)
**Usage**: Reusable component that can be called from multiple main deployments
**Build Command**: `az bicep build --file generic_module/module.bicep`

## Parser Testing Scenarios

When testing your parser with these files, consider:

### **Single-File Parsing**
- Each `.bicep` file should parse independently
- Test parameter validation and resource definitions

### **Multi-File Parsing** 
- Parse `main.bicep` + all referenced modules together
- Verify module parameter passing and dependency resolution
- Test output value propagation between modules

### **Complex Dependency Chains**
- Follow dependencies: `main.bicep` → `storage.bicep` → `application.bicep` → `rbac.bicep`
- Verify GUID generation and role assignment patterns

## Common ARM-to-Bicep Conversion Patterns

These files represent real patterns you'll encounter when ARM templates are converted:

1. **Modularization**: Large ARM templates → Multiple focused Bicep modules
2. **GUID Handling**: ARM GUID functions → Bicep guid() with consistent parameters
3. **Nested Resources**: ARM nested deployments → Bicep module calls
4. **Role Assignments**: Complex ARM RBAC → Clean Bicep role assignment modules
5. **Parameter Flow**: ARM parameter passing → Bicep module parameter chains

## Documentation Template Usage

For your parser documentation, you can show:

**Before (ARM)**: *[Large monolithic ARM template]*
**After (Bicep Multi-File)**: *[Multiple focused Bicep modules]*
**After (Parsed)**: *[Your parser's unified output representing the complete infrastructure]*
