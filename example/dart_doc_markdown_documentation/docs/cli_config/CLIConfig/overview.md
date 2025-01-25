# Overview for `CLIConfig`

## Description

Represents the configuration for the CLI tool parsed from arguments.

## Members

- **projectDirectory**: `String`
  The directory containing the Dart/Flutter project to document.

- **outputDirectory**: `String`
  The directory where the generated Markdown files will be stored.

- **verbose**: `bool`
  Optional flag to enable verbose logging.

## Constructors

### Unnamed Constructor
Constructor to initialize the CLI configuration.

### fromArguments
Factory method to parse and validate arguments.

#### Parameters

- `arguments`: `List<String>`
