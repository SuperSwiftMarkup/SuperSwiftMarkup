# The SuperSwiftMarkup — Markdown Libraries

## As of 2025-1-28

**Public Entry-point:**
- `SSMarkdown`: The public API which reexports:
    - `SSMarkdownView`: The SwiftUI markdown view. Reexported by `SSMarkdown`.
    - `SSMarkdownFormat`: The Markdown AST / data model and related code. Reexported by `SSMarkdown` 

**Low-Level Libraries:**
- `ssm-rich-text-engine`: The low-level implementation of the SSM rich text view; implemented in terms of TextKit 2 APIs and platform specific UI frameworks. This library reexports:
    - `ssm-system-utilities`: Mostly cross platform type aliases and other misc code.

**Utility Libraries:**
- `SSDocumentAction`: commonly used data types for defining document behavior and hotkeys.

---

In general the “easy to use” public API is all exported under `SSMarkdown`. By default this will export a SwiftUI compatible view. 

If you need access to the underlying platform specific view references, please see the more low-level `ssm-rich-text-engine` rendering library which you should only use if you know what you're doing. 

In general the API is unstable but everything under `ssm-rich-text-engine` is especially so. 
