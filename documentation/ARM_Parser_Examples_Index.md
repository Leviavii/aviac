# ARM Parser Examples Index

This document provides a complete index of all ARM template examples and their corresponding parsed outputs created by the `wizcli` parser.

## Available Test Files and Parsed Outputs

| Example | Original ARM Template | Parsed Output | Focus Area |
|---------|----------------------|---------------|------------|
| **1. Simple Storage** | `ARM_templates/1_simple_storage.json` | `ARM_templates/parsed/1_simple_storage.json_0.json` | Basic resource definition, parameters |
| **2. Web App with Parameters** | `ARM_templates/2_webapp_with_params.json` | `ARM_templates/parsed/2_webapp_with_params.json_0.json` | Parameter validation, conditionals, dependencies |
| **3. Function Transformations** | `ARM_templates/3_function_transformations.json` | `ARM_templates/parsed/3_function_transformations.json_0.json` | ARM functions, string operations, secrets |
| **4. Complex Multi-Tier** | `ARM_templates/4_complex_multi_tier.json` | `ARM_templates/parsed/4_complex_multi_tier.json_0.json` | Multi-resource dependencies, environment configs |
| **5. String & Array Functions** | `ARM_templates/5_string_and_array_functions.json` | `ARM_templates/parsed/5_string_and_array_functions.json_0.json` | String manipulation, array operations, object merging |
| **6. Loops & Math Functions** | `ARM_templates/6_loops_and_math_functions.json` | `ARM_templates/parsed/6_loops_and_math_functions.json_0.json` | Resource loops, mathematical calculations, conditional deployment |
| **7. Advanced Functions** | `ARM_templates/7_advanced_functions.json` | `ARM_templates/parsed/7_advanced_functions.json_0.json` | GUID generation, encoding/decoding, metadata access |
| **8. Networking & VM** | `ARM_templates/8_networking_and_vm.json` | `ARM_templates/parsed/8_networking_and_vm.json_0.json` | Complex networking, VMs, resource interdependencies |

## ARM Functions Coverage Matrix

| Function Category | Examples | Covered Functions | Test Files |
|------------------|----------|-------------------|------------|
| **Basic Functions** | Parameter access, variables | `parameters()`, `variables()`, `resourceGroup()`, `resourceId()` | 1, 2, 3, 4 |
| **String Functions** | Text manipulation | `concat()`, `split()`, `replace()`, `substring()`, `length()`, `contains()`, `take()` | 3, 5 |
| **Array Operations** | Array processing | Array indexing `[0]`, `length()`, array parameters | 5, 6 |
| **Math Functions** | Calculations | `add()`, `mul()`, `div()`, `sub()`, `mod()`, `greater()` | 6 |
| **Object Functions** | Object manipulation | `union()`, `createObject()` | 5 |
| **Advanced Functions** | System functions | `guid()`, `base64()`, `json()`, `subscription()`, `deployment()`, `utcNow()` | 7 |
| **Conditional Logic** | Decision making | `if()`, `and()`, `or()`, `not()`, `equals()` | 2, 4, 5, 6 |
| **Resource Functions** | Resource operations | `reference()`, `listKeys()` | 3, 4 |
| **Loop Constructs** | Iterative creation | `copy`, `copyIndex()` | 6 |

## Parser Output Characteristics

### Consistent Transformations Across All Examples:

1. **JSON Minification**
   - Multi-line → Single-line format
   - Whitespace removal
   - Consistent property ordering

2. **Structure Standardization** 
   - `$schema` → `contentVersion` → `outputs` → `parameters` → `resources` → `variables`
   - Consistent property ordering within each section

3. **Function Preservation**
   - All ARM functions maintained exactly as written
   - Complex nested expressions preserved
   - Parameter and variable references intact

4. **Logical Equivalence**
   - Identical deployment behavior
   - Same resource creation and configuration
   - Preserved dependencies and relationships

## Usage Scenarios

### For Documentation:
- **Template Comparison**: Before/after examples showing parser normalization
- **Function Reference**: Examples of how each ARM function is preserved
- **Integration Guide**: How parsed output integrates with downstream tools

### For Development:
- **Pipeline Integration**: Standardized input for processing tools
- **Validation Testing**: Normalized format for consistent validation
- **Template Analysis**: Clean format for automated analysis tools

### For Testing:
- **Parser Validation**: Verify all ARM functions are correctly preserved
- **Regression Testing**: Ensure consistent output across parser versions
- **Compatibility Testing**: Verify ARM template compatibility is maintained

## File Locations

```
/Users/avi.leviav/Desktop/IacParsing/arm/test_files/paired_examples/
├── ARM_templates/                     ← Original ARM JSON templates
│   ├── 1_simple_storage.json         
│   ├── 2_webapp_with_params.json     
│   ├── 3_function_transformations.json
│   ├── 4_complex_multi_tier.json     
│   ├── 5_string_and_array_functions.json
│   ├── 6_loops_and_math_functions.json
│   ├── 7_advanced_functions.json     
│   ├── 8_networking_and_vm.json      
│   └── parsed/                        ← Parsed outputs by wizcli
│       ├── 1_simple_storage.json_0.json
│       ├── 2_webapp_with_params.json_0.json
│       ├── 3_function_transformations.json_0.json
│       ├── 4_complex_multi_tier.json_0.json
│       ├── 5_string_and_array_functions.json_0.json
│       ├── 6_loops_and_math_functions.json_0.json
│       ├── 7_advanced_functions.json_0.json
│       └── 8_networking_and_vm.json_0.json
└── Bicep_templates/                   ← Equivalent Bicep templates
    ├── [1-8 corresponding .bicep files]
    └── 9_multi_file_scenarios/        ← Multi-file Bicep examples
```

## Integration Commands

### Parse ARM Templates:
```bash
wizcli iac parse --path "ARM_templates/" --output-folder "ARM_templates/parsed/" --matcher-type AzureResourceManager
```

### Parse Individual File:
```bash
wizcli iac parse --path "ARM_templates/1_simple_storage.json" --output-folder "ARM_templates/parsed/" --matcher-type AzureResourceManager
```

### Parse Bicep Templates:
```bash
wizcli iac parse --path "Bicep_templates/" --output-folder "Bicep_templates/parsed/" --matcher-type Bicep
```

This comprehensive test suite provides complete coverage of ARM template patterns and parser behavior for documentation, testing, and integration purposes.
