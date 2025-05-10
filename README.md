# 🚧 Work in Progress

### Preamble

This project began as a [proof-of-concept prototype](https://github.com/SuperSwiftMarkup/SuperSwiftMarkdownPrototype). That prototype proved the concept was viable—so now we're starting fresh, with a complete rewrite aimed at building easy-to-use libraries for integration by third-party developers.

This repository is a clean slate. For project history, screenshots, and the "super cool" original work, check out the [prototype repo](https://github.com/SuperSwiftMarkup/SuperSwiftMarkdownPrototype).

If you're interested in contributing or helping shape the evolution of *SuperSwiftMarkup*, now is the time. Otherwise, feel free to check back periodically for a production-ready release.

**I'm excited—and I hope you are too!**
I’m Colbyn Wadman, and I’ve been tinkering with text processing and rendering for years. It’s been rewarding to see this project take shape, and I look forward to sharing something meaningful with the community. 🤞

---

# 📣 Marketing Abstract

It’s no longer easy to stand out on the App Store. Apps are ubiquitous, and native UI frameworks are losing ground to web tech—unfortunately.

**SuperSwiftMarkup** aims to deliver next-generation native text views that rival and exceed the UX capabilities of web technologies—giving your apps a real competitive edge.

(iOS users, in particular, have high expectations for text interactions. Just ask the Flutter team.)

---

# 👨‍💻 Developer Introduction

**Welcome to SuperSwiftMarkup**—a suite of libraries and tools for rendering and editing rich text, starting with markdown and extending to more complex formats like LaTeX.

### Vision

Our goal is to provide *first-class*, cross-platform support for rich text views that natively handle the full range of Markdown (and beyond). That includes:

* Support for all markdown block types with native selection, even across mixed content blocks.
* Layout behaviors that feel intuitive on both iOS and macOS.
* Extensibility for additional markup types (e.g., **LaTeX math**).

### Why This Matters

Native text views (like UITextView or NSTextView) offer only *basic* markdown support—typically just inline formatting inside paragraph blocks. For anything more, developers are on their own.

Common workarounds (like SwiftUI views or web views) often sacrifice critical features like cross-block selection, native accessibility, or integration with platform behaviors. Editing? Even harder.

**SuperSwiftMarkup** exists because no current solution is good enough. We want to change that.

---

# ✂️ TL;DR

**Core Objectives:**

* ✅ Full markdown block support with consistent selection/navigation.
* ✅ Cross-platform, multi-selection/cursor support.
* ✅ Out-of-the-box UX behaviors expected by iOS/macOS users (see [Appendix](#appendix)).

**Key Design Considerations:**

* Optional **horizontal scrolling** for wide content like tables (as an alternative to wrapping).
* Clear separation between read-only rendering and editing workflows.

---

# 🛠️ Development Status

### Current Focus

1. **Editing Support:**
   Not included in the original prototype and technically complex due to API limitations and unknowns. Still under exploration.

2. **Typesetting Library:**
   In progress now. This will support **read-only rendering**, with robust selection/navigation—suitable for embedding into third-party apps.

### Planned Architecture

* **Typesetting Libraries**

  * Read-only, lossy ASTs acceptable.
  * Prioritizes rendering quality and platform-native behaviors.
* **Rich Text Editing Libraries**

  * Lossless ASTs (isomorphic to the source text).
  * Maintains exact formatting, whitespace, and user input fidelity.

**This split allows:**

* Stability and focus for display-only use cases.
* Independent evolution of editing tools to support real-world editing needs.

---

# 📚 Appendix

## Supported Markup

We aim to fully support:

* [CommonMark Spec](https://spec.commonmark.org/0.31.2/)
* [GitHub Flavored Markdown (GFM)](https://github.github.com/gfm/)

### Planned Extensions

* **LaTeX Math**
  *Looking for a lightweight, embeddable renderer (<2MB). Suggestions welcome!*
* **Frontmatter Metadata**
* Additional extensions as requested—reach out in the discussions!

---

## UX: Meeting User Expectations on iOS & macOS

We aim to replicate the full spectrum of native text behavior users expect, including:

### Selection & Interaction

* **Tap and Hold**, **Drag Handles**
* **Double/Triple/Quadruple Tap**: word → paragraph → entire document
* **Context Menu**: Cut, Copy, Paste, Replace, Look Up, Share, Translate, Speak

### Smart Selection & Detection

* Intelligent chunking (e.g. addresses, dates)
* Data detectors (e.g. create events from dates)

### Spell & Grammar

* Auto-correction, suggestions, underlines
* Context-aware: ignores code, LaTeX, inline HTML, etc.

### Voice & Accessibility

* Voice control, dictation, VoiceOver
* Switch Control, TTS, and other accessibility tools

### Multilingual & Input

* Language detection
* Keyboard/input method support

### Advanced Tools

* Find & Replace
* Case transforms
* Smart text wrapping

### Clipboard & Drag-and-Drop

* Clipboard history
* Intra/inter-app drag-and-drop

### Platform-Specific Features

* **iOS**: QuickType, Shortcuts
* **macOS**: Services menu, advanced speech tools

### Extras

* **Text Annotation**: highlights, comments
* **Code Syntax Highlighting**: lazy-loaded, spell-check for comments only
