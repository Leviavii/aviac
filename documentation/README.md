# ARM & Bicep Parser Documentation Suite

This directory contains comprehensive documentation and test files for the `wizcli` Infrastructure-as-Code parser, specifically focused on Azure Resource Manager (ARM) templates and Bicep files.

## 📋 Documentation Files

| Document | Description | Purpose |
|----------|-------------|---------|
| **`ARM_Parser_Documentation.md`** | **Main documentation** showing before/after examples | Primary documentation with detailed parser behavior examples |
| **`ARM_Parser_Examples_Index.md`** | Complete index of all test files and their outputs | Quick reference and file location guide |
| **`README.md`** | This overview file | Navigation and setup guide |

## 🎯 Quick Start

### 1. View Parser Documentation
```bash
# Main documentation with examples
open ARM_Parser_Documentation.md

# Complete index of all examples  
open ARM_Parser_Examples_Index.md
```

### 2. Access Test Files
```bash
# Original ARM templates
ls test_files/paired_examples/ARM_templates/

# Parsed outputs by wizcli
ls test_files/paired_examples/ARM_templates/parsed/

# Equivalent Bicep templates
ls test_files/paired_examples/Bicep_templates/
```

### 3. Run Parser Tests
```bash
# Parse ARM templates
wizcli iac parse --path "test_files/paired_examples/ARM_templates/" --output-folder "test_files/paired_examples/ARM_templates/parsed/" --matcher-type AzureResourceManager

# Parse Bicep templates  
wizcli iac parse --path "test_files/paired_examples/Bicep_templates/" --output-folder "test_files/paired_examples/Bicep_templates/parsed/" --matcher-type Bicep
```

## 🔧 What's Included

### ARM Template Examples (8 Files):
1. **Simple Storage Account** - Basic resource definition
2. **Web App with Parameters** - Parameter validation, conditionals
3. **Function Transformations** - ARM functions, string operations
4. **Complex Multi-Tier Application** - Multiple resources, dependencies
5. **String & Array Functions** - Text manipulation, array operations
6. **Loops & Math Functions** - Resource loops, calculations
7. **Advanced Functions** - GUID generation, encoding, metadata
8. **Networking & Virtual Machine** - Complex networking, VMs

### Bicep Template Examples:
- **8 Paired Bicep Files** - Equivalent to each ARM template
- **Multi-File Scenarios** - Modular Bicep deployments with multiple files

### Parser Output Analysis:
- **Before/After Comparisons** - Original vs. parsed formats
- **Function Preservation** - How ARM functions are maintained
- **Structure Standardization** - Consistent formatting behavior

## 📊 Parser Behavior

The `wizcli` parser with `--matcher-type AzureResourceManager`:

### ✅ What It Does:
- **Minifies JSON** - Single-line format for efficient processing
- **Standardizes Structure** - Consistent property ordering
- **Preserves ARM Functions** - All expressions like `[parameters()]`, `[variables()]` maintained
- **Maintains Logic** - Identical deployment behavior

### ❌ What It Does NOT Do:
- Does not evaluate ARM functions (preserves `[parameters()]` as-is)
- Does not resolve dependencies (maintains `dependsOn` arrays)
- Does not validate resources (preserves original resource definitions)
- Does not transform to other formats (output is still ARM JSON)

## 🎊 Perfect For:

### Documentation Teams:
- **Before/After Examples** - Clear transformation demonstrations
- **Function Reference** - Comprehensive ARM function coverage
- **Integration Guides** - How parsed output works with downstream tools

### Development Teams:
- **Pipeline Integration** - Standardized input for processing pipelines
- **Template Validation** - Normalized format for consistent validation
- **Automated Testing** - Predictable format for test assertions

### DevOps Teams:
- **CI/CD Integration** - Consistent template format for automated workflows
- **Infrastructure Analysis** - Clean format for analysis tools
- **Template Management** - Normalized format for template libraries

## 🚀 Advanced Usage

### Multi-File Bicep Parsing:
```bash
# Parse main orchestration scenario
wizcli iac parse --path "test_files/paired_examples/Bicep_templates/9_multi_file_scenarios/main_orchestration/" --matcher-type Bicep

# Parse nested deployment scenario
wizcli iac parse --path "test_files/paired_examples/Bicep_templates/9_multi_file_scenarios/nested_deployment/" --matcher-type Bicep
```

### Validation & Testing:
```bash
# Validate ARM templates convert to Bicep
az bicep decompile --file test_files/paired_examples/ARM_templates/1_simple_storage.json

# Validate Bicep templates build to ARM
az bicep build --file test_files/paired_examples/Bicep_templates/1_simple_storage.bicep
```

This documentation suite provides everything needed to understand, test, and integrate the `wizcli` parser with ARM and Bicep Infrastructure-as-Code workflows.

---

**Created for comprehensive Infrastructure-as-Code parser documentation and testing** 🎯
