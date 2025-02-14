# Update 2025-2-14 

**I’m no longer concerned about supporting a general purpose markdown display and editor view unless someone is willing to sponsor such to completion.** 

For now, my concerns are the immediate needs of a commercial project based on a fresh renovation of my old [note taking markup format]( https://github.com/subscript-publishing/subscript ) but reimagined in a manner not expressible as plaintext because I may as well apply my TextKit 2 capabilities and crate something totally unique in the market space. **Codenamed ‘punk’.**

This new format will finally accomplish my end goal of seamless typed markup and freeform content, with responsive layout that defines the presentation of information in as compact and maximally saturated a manner as possible that looks great on any device. Overall I want beautifully typeset information including the arrangement of freeform content. 

The ultimate end goal is note publishing of the highest quality not mere note taking, and in a manner that presents best in web browsers as self contained webpages that will stand the test of time with regard to your painstakingly produced notes. I want notes that one can look back on in old age and admire their youthful work.

(Also because everything nowadays has to pertain or relate to AI in one way or another: no LLMs won’t supersede a great personal note taking platform. If anything, while I’m against relying on LLMs over developing your personal skills, there have been times where I’ll get some LLM in such a state that it actuality produces something interesting and sometimes I do wish I had a medium where I could save such in a neatly organized and arranged manner.) 

**Also regarding naming conventions:** because some people have problems with the ‘SS’ prefix, I’ve since decided that ‘DD’ is actually easier to type, but I’ve already grown accustomed to the ‘SS’ prefix for all top-level publicly exposed top-level identifiers and furthermore many projects are based on this naming convention… So such may be what I’m stuck with but henceforth I’ll focus more on names of two words that begin with a ‘d’. (Personally as someone whose ancestors fought the axis powers I don’t think such is a bit deal and typing efficiency is most pressing on my mind as a programmer.) 

**Everything below** are my prior notes with regard to a general purpose markdown display and editor view.

---

# Work In Progress 

**Preamble:**

Initially the work began with a proof-of-concept prototype project ([see here]( https://github.com/SuperSwiftMarkup/SuperSwiftMarkdownPrototype )) and now that such has been proven viable, the work herein is a fresh continuation of the aforementioned POC prototype but as a complete rewrite and now with an eye towards designing easy-to-use libraries for integration by third party developers.

The git tree is also a fresh start, so head over to the aforementioned [POC prototype](https://github.com/SuperSwiftMarkup/SuperSwiftMarkdownPrototype) to see the past history and screenshots from where that project left off (spoiler alert it’s super cool).

Unless you’re interested in contributing towards or influencing the initial evolution of the SuperSwiftMarkup libraries, **please check back** every so often to see when this is ready for real world use. 

**But overall I hope you’re excited as I am!** 

Personally I, the author (Colbyn Wadman), have been messing around with miscellaneous problems concerning text processing and text rendering (in one form or another) for a very long time and—as far as the POC has demonstrated—it’s good to see something interesting come from it, and when I release my work, I hope you’ll be pleased with the results. 🤞

# Marketing Abstract

Nowadays it’s not so easy to become an App Store millionaire when apps are a dime a dozen and especially when native UI frameworks have been losing their competitive edge with regard to web technologies (which is a shame in and of itself).   

The overarching goal of the SuperSwiftMarkup libraries is to deliver the next generation of text views that support user experiences unparalleled by web technologies. So that you can squeeze out that extra competitive edge in this hyper saturated and globalized marketplace of software.

(Luckily iOS users have been known to be especially picky when it comes to text functionality. Just ask the Flutter team.) 

# Introduction for Developers

**Welcome to the Super Swift Markup libraries, apps and whatnot.** Collectively referred to as the *Super Swift Markup* projects. 

**Overall:** 

The overarching goal of the *Super Swift Markup* projects is to build the best iOS & macOS rich text views, starting with the *markdown* format as the base, which may be extended over time to support other markup formats (including **LaTeX math**) on an as needed basis.

In general, what we want may be called “first class” markdown support as a text view. Meaning that all markdown block types are supported as rich text, and in a manner that accommodates all platform specific text view behaviors that users may expect (see “Meeting the expectations of iOS and macOS users” under the [Appendix](#Appendix)). Including the ability to select arbitrary text within any markdown block type and with the ability to extend such a selection across multiple and varying markdown block types.

**Rationale:**

When it comes to supporting markdown is your app, platform specific native text views only support a limited subset of markdown. Which is generally limited to just basic inline formatting within paragraph blocks and nothing more.
 
As far as supporting the full range of e.g. the GitHub Flavored Markdown Spec, not only are you out-of-luck but there is little to no support at the level of basic building blocks. Technically TextKit has a concept of “text tables”, but it’s limited to just AppKit with no support for iOS. 

In general **developers are left to their own devices** and while there are many preexisting markdown rendering libraries, none so far are satisfactory.

Also with regard to “developers are left to their own devices”, you yourself are a *do-it-yourself* kinda person. Technically, building a markdown preview in terms of SwiftUI views is super easy, but the tradeoff here is no text selection across distinct text views. Likewise, building a markdown preview via an embedded web view is also super easy but the tradeoff here is that web views are themselves black boxes that don't integrate well with the native UI system. E.g. when nested in complex view trees, web views will break layout, and if you need to extend the default text selection behavior to support app specific behavioral requirements, IMO such is a problem that no web app has yet to solve. So technically there are solutions, but none—so far—are satisfactory, and furthermore **if you also need to support edit-ability:** good luck.      

# TL;DR

Generally speaking the overarching directives are, 

- First class (cross platform) support for all markdown block types, with uniform behavior concerning text selection and selection-based navigation.
- First class (cross platform) support for multiple cursors/selections.
- Default support for everything under "Meeting the expectations of iOS and macOS users" (see [Appendix](#Appendix)).

Where the rendering engine is designed in such a way that can accommodate the following: 

- Horizontally scrollable fragments (on a per-fragment basis) as an alternative to text wrapping. Which is particularly desirable for e.g. long tables that cannot neatly fit within their available view space.   

---

# Current Development Notes 

Consider the following,

1. The one missing component that was not demonstrated in the POC prototype project was document editing, which is a more technically challenging task due to a few known concerns with potentially numerous unknowns that may require some API evolutions to get right.
2. At the same time read-only rendering can be factored out—now—into a standalone library.  

Overall, I think I’m going to split the libraries into two main categories which I call the,
- **Typesetting Libraries:** supports text selection and navigation but in **read-only** mode and may use **lossy ASTs** / data models without any concern. 
- **Rich Text Editing Libraries:** ideally based on lossless ASTs where the parsed representation should preserve all information including arbitrary whitespace. I call this isomorphic data modeling with regard to source-code parsing and string formatting. 

Which solves a couple problems such that,
1. The typesetting libraries can evolve to simply focus on beautifully rendered documents, while providing a more stable API for third party application developers who only need rich text display (with text selection and navigation support).     
2. While the document editing libraries can independently evolve to best address the nuances of document editing. 


---

# Appendix

## Concerning Markup Formats

Since markdown itself is a patchwork of standards, when we say “markdown“ we are referring to the following:

- All markdown block and inline types as defined in the [CommonMark Spec]( https://spec.commonmark.org/0.31.2/ ).
- As well as all CommonMark extensions as defined in the [GitHub Flavored Markdown Spec]( https://github.github.com/gfm/ ).

With an eye towards supporting the following extensions long term:
- **LaTeX math**
    - **Note:** we are in need of LaTeX math renderer that is easily embeddable and lightweight (the compiled dependency should be less than 2MB). If you have any suggestions please reach out in the discussions area.
- **Frontmatter Metadata**
- **Others:** If you’d like to see support for other markdown extensions not mentioned here, please reach out in the discussions area.

## Meeting the expectations of iOS and macOS users

Our goal is to provide a rich and intuitive text selection experience that meets the expectations of iOS and macOS users. This includes a comprehensive set of features that enhance usability and productivity. Here's what we aim to support:

### Basic Text Selection
- **Tap and Hold**: Select a word by tapping and holding on it.
- **Drag Handles**: Adjust the selection by dragging the handles that appear at the start and end of the selected text.

### Double-Tap and Triple-Tap
- **Double-Tap**: Select a word.
- **Triple-Tap**: Select a paragraph.
- **Quadruple-Tap**: Select the entire text (in some applications).

### Context Menu
- **Cut, Copy, Paste**: Standard text manipulation options.
- **Replace**: Suggest replacements for the selected text.
- **Look Up**: Provide definitions, synonyms, and other relevant information.
- **Share**: Share the selected text via various apps and services.
- **Translate**: Translate the selected text into another language.
- **Speak**: Read the selected text aloud.

### Smart Selection
- **Intelligent Selection**: Automatically selects meaningful chunks of text, such as addresses, phone numbers, and dates.
- **Data Detectors**: Recognize and act on specific types of data (e.g., create a calendar event from a selected date).

### Spell and Grammar Checking

- **Automatic Correction**: Suggest and apply corrections for spelling and grammar errors.
- **Underline Errors**: Highlight spelling and grammar errors with underlines.
- **Suggestions**: Provide suggestions for correcting errors.

But in a context specific manner—by default—that ignores text in HTML tags, LaTeX math commands, inline code, code blocks (except for comments when syntax highlighting is available), etc.

### Voice Control
- **Voice Commands**: Use voice commands to select, edit, and manipulate text.
- **Dictation**: Convert spoken words into text.

### Accessibility Features
- **VoiceOver**: Read selected text aloud for visually impaired users.
- **Switch Control**: Use adaptive switches to select and manipulate text.
- **Text to Speech**: Convert selected text to speech.

### Multilingual Support
- **Language Detection**: Automatically detect and switch keyboards based on the language of the selected text.
- **Input Methods**: Support for various input methods and keyboards for different languages.

### Advanced Text Manipulation
- **Find and Replace**: Search for text and replace it with another string.
- **Text Transformation**: Convert text to uppercase, lowercase, or capitalize each word.
- **Text Wrapping**: Control how text wraps within a container.

### Clipboard Management
- **Multiple Clipboard Items**: Manage multiple copied items.
- **Clipboard History**: Access a history of copied items.

### Drag and Drop
- **Text Dragging**: Drag selected text to another location within the same app or to another app.
- **Drop Targets**: Drop selected text into compatible drop targets.

### Platform-Specific Features

#### iOS
- **QuickType Keyboard**: Predictive text and autocorrect.
- **Shortcuts**: Text replacement and keyboard shortcuts.

#### macOS
- **Services Menu**: Additional text services.
- **Dictation and Speech**: Enhanced dictation and text-to-speech features.


### Additionally

#### Text Annotation
- **Highlight**: Highlight selected text with different colors.
- **Comments**: Add comments or notes to selected text.

#### Code Block Syntax Highlighting 

- Automatic lazy loading of syntax highlighting code when available. 
- Additional smart spell checking support for comments within code blocks.

