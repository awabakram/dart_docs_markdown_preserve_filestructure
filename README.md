# Dart Docs Markdown

**Dart Docs Markdown** is a CLI tool that generates Markdown documentation for Dart/Flutter
projects. The tool is designed to provide an easy way to integrate your code documentation into
systems like Docusaurus, GitBook, or other documentation platforms that support Markdown files.

## Overview

This tool traverses the directory structure of a Dart/Flutter project, analyzes its files, and
generates Markdown documentation for classes, methods, and other code elements. The output is
formatted for use in documentation systems, making it ideal for teams that manage developer or
project documentation in platforms designed for Markdown.

## Use Case

The primary use case for **Dart Docs Markdown** is to bridge the gap between traditional code
documentation tools and modern documentation systems. By generating Markdown files, this tool
enables developers to:

- Integrate code documentation into platforms like **[Docusaurus](https://docusaurus.io/)**, **[GitBook](https://www.gitbook.com/)**, or **[ReadMe](https://readme.com/)**.
- Maintain code documentation alongside other project documentation.
- Customize and enhance documentation workflows with Markdown-based systems.

## How This Tool Differs from Dartdoc

The `dartdoc` package and **Dart Docs Markdown** serve different purposes:

### Dartdoc

- **Output Format**: Generates static HTML files.
- **Use Case**: Creates a self-contained documentation site that can be hosted directly on a server.
- **Deployment**: Suitable for teams that want a standalone documentation site without external
  integration.

### Dart Docs Markdown

- **Output Format**: Generates Markdown files.
- **Use Case**: Designed for integration into documentation systems like:
    - **[Docusaurus](https://docusaurus.io/)**
    - **[GitBook](https://www.gitbook.com/)**
    - **[MkDocs](https://www.mkdocs.org/)**
    - **[ReadMe](https://readme.com/_**
- **Deployment**: Ideal for teams already using systems that support Markdown to manage
  documentation.

If you need a standalone documentation site, `dartdoc` is the better choice. If you need
documentation that integrates with other tools and workflows, **Dart Docs Markdown** is the right
solution.

## Installation

Install the tool by adding it to your Dart project or using the global executable:

```bash
# Add to your Dart project
dart pub add dart_docs_markdown

# Install globally
dart pub global activate dart_docs_markdown
```

## Usage

### Generate Markdown Documentation

To generate Markdown documentation for your project:

1. Run the CLI tool with the required arguments:

```bash
dart run dart_docs_markdown <project_directory> <output_directory>
```

- **`<project_directory>`**: The root directory of your Dart/Flutter project.
- **`<output_directory>`**: The directory where the generated Markdown files will be stored.

Example:

```bash
dart run dart_docs_markdown ./my_flutter_project ./docs
```

This command scans the `my_flutter_project` directory and generates Markdown documentation in the
`docs` folder.

### Example Output

After running the tool, the `docs` directory will contain:

```
docs/
├── lib-main.md
├── lib-auth-service.md
└── lib-ui-components.md
```

Each Markdown file represents a Dart file in your project, containing:

- Classes and their descriptions
- Methods with parameter and return type information
- Any Dartdoc comments present in the source code

### Customize Configuration

You can configure the tool using a `.dartdocmarkdownrc` file (optional) to specify:

- Files or directories to ignore
- Formatting preferences
- Custom output paths

## Project Structure

The project structure is organized as follows:

```text
dart_to_docusaurus/
├── bin/
│   ├── dart_to_markdown.dart   # Entry point for the CLI tool
├── lib/
│   ├── dart_to_markdown.dart   # Main library file, exporting core functionality
│   ├── src/
│   │   ├── directory_traversal.dart   # Handles project directory traversal
│   │   ├── dart_parser.dart           # Parses Dart files using analyzer
│   │   ├── markdown_generator.dart    # Generates Markdown from parsed data
│   │   ├── file_writer.dart           # Writes Markdown files to the output directory
│   │   ├── config_manager.dart        # Manages configuration options (e.g., ignores, custom settings)
├── test/
│   ├── directory_traversal_test.dart   # Unit tests for directory traversal
│   ├── dart_parser_test.dart           # Unit tests for Dart file parsing
│   ├── markdown_generator_test.dart    # Unit tests for Markdown generation
│   ├── file_writer_test.dart           # Unit tests for file writing
│   ├── integration_test.dart           # Integration tests for end-to-end functionality
├── tool/
│   ├── scripts/
│   │   ├── update_sidebar.js           # Optional: Automates updates to Docusaurus `sidebars.js`
├── example/
│   ├── example_project/                # Example Dart project for testing and showcasing the tool
│   │   ├── lib/
│   │   │   ├── example.dart
├── pubspec.yaml                        # Dart project configuration and dependencies
├── analysis_options.yaml               # Dart analysis and linting rules
├── CHANGELOG.md                        # Changelog for the CLI tool
├── LICENSE                             # License for the project
└── README.md  
```

## Contributing

Contributions are welcome! If you'd like to report issues or suggest features, feel free to open an
issue or submit a pull request on [GitHub](https://github.com/Toglefritz/dart_docs_markdown).

## License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.

