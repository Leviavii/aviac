# ARM & Bicep Paired Examples

This directory contains paired examples of identical infrastructure defined in both ARM JSON templates and Bicep templates. These are designed for creating documentation that shows "before ARM", "before Bicep", and "after parsed" formats for the same resources.

## Structure

```
paired_examples/
├── ARM_templates/           ← ARM JSON templates
│   ├── 1_simple_storage.json
│   ├── 2_webapp_with_params.json
│   ├── 3_function_transformations.json
│   ├── 4_complex_multi_tier.json
│   ├── 5_string_and_array_functions.json
│   ├── 6_loops_and_math_functions.json
│   ├── 7_advanced_functions.json
│   └── 8_networking_and_vm.json
└── Bicep_templates/         ← Corresponding Bicep templates
    ├── 1_simple_storage.bicep
    ├── 2_webapp_with_params.bicep
    ├── 3_function_transformations.bicep
    ├── 4_complex_multi_tier.bicep
    ├── 5_string_and_array_functions.bicep
    ├── 6_loops_and_math_functions.bicep
    ├── 7_advanced_functions.bicep
    ├── 8_networking_and_vm.bicep
    └── 9_multi_file_scenarios/        ← Multi-file Bicep deployments
        ├── main_orchestration/         ← Main + modules scenario
        │   ├── main.bicep             ← Orchestrates storage/network/app/rbac modules
        │   └── [4 supporting modules] ← storage.bicep, networking.bicep, etc.
        ├── nested_deployment/         ← Nested deployment scenario
        │   ├── nested_deployment.bicep ← Orchestrates nested modules
        │   └── [3 supporting modules] ← nested_storage.bicep, etc.
        ├── guid_scenario/             ← GUID-based deployment
        │   └── guid.bicep             ← Standalone GUID example
        └── generic_module/            ← Generic module scenario
            └── module.bicep           ← Standalone module example
```

## Examples Overview

### 1. Simple Storage Account
- **ARM**: Basic storage account with parameters and outputs
- **Bicep**: Equivalent using Bicep syntax with cleaner parameter declarations
- **Focus**: Basic resource definition, parameter handling

### 2. Web App with Parameters
- **ARM**: App Service Plan + Web App with conditional logic
- **Bicep**: Same resources using `@allowed` decorator and ternary operators
- **Focus**: Parameter validation, conditional expressions, resource dependencies

### 3. Function Transformations
- **ARM**: Storage account using `concat()`, `uniqueString()`, `reference()`, `listKeys()` functions
- **Bicep**: Same functionality using string interpolation and simplified syntax
- **Focus**: ARM function transformations, string operations, secrets handling

### 4. Complex Multi-Tier Application
- **ARM**: Storage + SQL Server + Database + App Service Plan + Web App
- **Bicep**: Same multi-tier architecture with cleaner resource references
- **Focus**: Complex dependencies, multiple resource types, environment-based configurations

### 5. String and Array Functions
- **ARM**: Uses `split()`, `replace()`, `substring()`, `length()`, `contains()`, `union()`, `utcNow()`
- **Bicep**: Equivalent functions with cleaner syntax and string interpolation
- **Focus**: String manipulation, array operations, object merging, date functions

### 6. Loops and Math Functions
- **ARM**: Resource loops with `copy`, math functions `add()`, `mul()`, `div()`, `sub()`, `mod()`
- **Bicep**: For loops and mathematical operators
- **Focus**: Iterative resource creation, mathematical calculations, conditional resource deployment

### 7. Advanced Functions
- **ARM**: `guid()`, `base64()`, `json()`, `base64ToJson()`, `subscription()`, `deployment()` functions
- **Bicep**: Same functions with cleaner nested resource syntax
- **Focus**: Encoding/decoding, metadata access, unique identifiers, Key Vault usage

### 8. Networking and Virtual Machine
- **ARM**: Complete VM deployment with VNet, NSG, Public IP, NIC using complex object mappings
- **Bicep**: Same infrastructure with simplified resource references and object syntax
- **Focus**: Complex networking, virtual machines, resource interdependencies, allowedValues

### 9. Multi-File Bicep Scenarios
- **Purpose**: Demonstrates Bicep deployments that span multiple files (common ARM conversion result)
- **Includes**: Main orchestration files, storage/networking/app/RBAC modules, GUID-based deployments, nested patterns
- **Focus**: Module dependencies, parameter passing, complex deployment orchestration, real-world patterns
- **Parser Challenge**: Parse multiple related .bicep files together to understand complete infrastructure

## Usage

Each paired example represents **identical infrastructure** that will:
- Deploy the same Azure resources
- Have the same configuration and properties
- Produce equivalent results when parsed

Perfect for documentation showing:
```
Before (ARM JSON) → After (Parsed Format)
Before (Bicep)    → After (Parsed Format)
```

## Validation

All examples have been validated to:
- ✅ ARM templates convert successfully to Bicep using `az bicep decompile`
- ✅ Bicep templates build successfully to ARM using `az bicep build`
- ✅ Both formats represent functionally identical infrastructure