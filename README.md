# Aviac - Infrastructure as Code Templates and Documentation

This repository contains a comprehensive collection of ARM templates, Bicep templates, and parser documentation.

## Repository Structure

```
📁 arm-templates/          # Azure Resource Manager JSON templates
📁 bicep-templates/        # Bicep template files  
📁 multi-file-bicep/       # Complex multi-file Bicep scenarios
📁 documentation/          # Parser guides and documentation
📁 examples/               # Example usage and README files
```

## ARM Templates (`arm-templates/`)

Collection of ARM templates covering:
- Simple storage accounts
- Web applications with parameters
- Function transformations
- Complex multi-tier architectures
- String and array functions
- Loops and math functions
- Advanced functions and conditions
- Networking and VM configurations

## Bicep Templates (`bicep-templates/`)

Paired Bicep templates that represent the same infrastructure as the ARM templates:
- Simplified syntax
- Type safety
- Modular design
- Better readability

## Multi-File Bicep Scenarios (`multi-file-bicep/`)

Complex Bicep deployments with multiple files:
- **main_orchestration/**: Main deployment with separate modules
- **nested_deployment/**: Nested deployment patterns
- **guid_scenario/**: GUID generation scenarios
- **generic_module/**: Reusable module patterns

## Documentation (`documentation/`)

- **ARM_Parser_Documentation.md**: Complete ARM template parser guide
- **ARM_Parser_Examples_Index.md**: Index of all parser examples
- **README.md**: General documentation overview

## Examples (`examples/`)

Usage examples and additional documentation for understanding the template structure and parser behavior.

---

*This repository serves as a comprehensive resource for Infrastructure as Code development and parsing documentation.*
