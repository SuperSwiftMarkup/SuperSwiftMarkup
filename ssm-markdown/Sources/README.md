# The SuperSwiftMarkup — Markdown Libraries

## As of 2025-1-28

**Overview:

- `SSMarkdown`: The public API. 
- `SSDocumentAction`: commonly used data types for defining document behavior and hotkeys.
- `SSMarkdownView`: The SwiftUI markdown view.
- `SSMarkdownFormat`: The Markdown AST / data model and related code.
- `SSMarkdownEngine`: The low-level implementation of the SSM Markdown text view.
- `SSMUtilities`: common stuff used throughout the SSM ecosystem.

In general the “easy to use” public API is all exported under `SSMarkdown`. By default this exports a SwiftUI compatible view. 

If you need access to the underlying platform specific view references, please see the more low-level `SSMarkdownEngine` rendering library which you should only use if you know what you're doing. 

In general the API is unstable but everything under `SSMarkdownEngine` is especially so. 
