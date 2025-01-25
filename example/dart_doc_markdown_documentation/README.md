# Example Docusaurus Site for `dart_doc_markdown`

This repository demonstrates how the `dart_doc_markdown` CLI tool can be used to generate Markdown
documentation for a Dart/Flutter project and integrate it into a Markdown-based documentation site
builder, in this case, Docusaurus. The documentation in this example site is for the CLI tool
itself.

## How This Site Was Created

The documentation in the `docs/` directory was generated using the `dart_doc_markdown` CLI tool. The
tool processes the source code for the CLI project and produces structured Markdown files. These
Markdown files were then used as the content for this Docusaurus site.

### Steps to Generate the Documentation

1. **Run the CLI Tool**:  
   The `dart_doc_markdown` tool was run with the `docs/` directory specified as the output
   directory:
   ```bash
   dart run ../bin/dart_doc_markdown.dart ../lib ./docs
   ```

This command:

- Processes the source code of the dart_doc_markdown CLI tool located in the ../lib/ directory.
- Outputs the generated Markdown documentation to the docs/ directory.

2. Set Up Docusaurus:
   A minimal Docusaurus site was initialized to host the generated documentation. The site
   configuration specifies the docs/ directory as the source of the documentation content.

## Viewing the Documentation

You can view this documentation site in two ways:

### Online

The site is hosted at [https://dart-docs-markdown.web.app/](https://dart-docs-markdown.web.app/). Visit the URL to explore the documentation online.

### Run Locally

You can run the site locally by following these steps:

1. Navigate to the Site Directory:

   ```bash
   cd dart_doc_markdown_documentation
   ```

2. Install Dependencies:
   If not already installed, run:

   ```bash
   npm install
   ```

3. Start the Local Server:
   Run the following command to start the Docusaurus development server:

    ```bash
    npm run start
    ```

4. View the Site:
   Open your browser and navigate to [http://localhost:3000](http://localhost:3000) to view the
   documentation.

## Key Features of This Example

- **Markdown Integration**: Demonstrates how the dart_doc_markdown CLI tool’s output can seamlessly
  integrate with Docusaurus.
- **Self-Documentation**: Uses the tool to generate documentation for the tool itself.
- **Flexible Deployment**: Showcases how the Markdown files can be hosted online or run locally for
  development.
