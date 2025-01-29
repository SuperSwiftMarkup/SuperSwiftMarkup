// Created by Colbyn Wadman on 2025-1-28 (ISO 8601)
//
// All SuperSwiftMarkup source code and other software material (unless
// explicitly stated otherwise) is available under a dual licensing model.
//
// Users may choose to use such under either:
// 1. The GNU Affero General Public License v3.0 ("AGPLv3"); or
// 2. A commercial license, as specified in LICENSE file.
//
// By using any of the code, you agree to comply with the terms and conditions
// of either the AGPLv3 or the commercial license, depending on the license you
// select.
//
// https://github.com/SuperSwiftMarkup/SuperSwiftMarkup/blob/main/LICENSE.md

import ssm_system_utilities

#if os(macOS) && !targetEnvironment(macCatalyst)

public final class SSRichTextScrollView: NSScrollView {
    private var textContentStorage: NSTextContentStorage!
    private var textLayoutManager: NSTextLayoutManager!
    private var textDocumentView: SSRichTextView!
    
    public static func new() -> SSRichTextScrollView {
        let documentScrollView = SSRichTextScrollView()
        // - -
        let textLayoutManager = NSTextLayoutManager()
        let textContentStorage = NSTextContentStorage()
        // - -
        textContentStorage.textStorage!.setAttributedString(NSAttributedString(
            string: "Hello World!\nHello World!\nHello World!",
            attributes: [:]
        ))
        // - -
        textContentStorage.addTextLayoutManager(textLayoutManager)
        textContentStorage.primaryTextLayoutManager = textLayoutManager
        // - -
        let textContainer = NSTextContainer(size: NSSize(width: 200, height: 0))
        textLayoutManager.textContainer = textContainer
        // - -
        documentScrollView.textContentStorage = textContentStorage
        documentScrollView.textLayoutManager = textLayoutManager
        // - -
        documentScrollView.textDocumentView = SSRichTextView()
        documentScrollView.textDocumentView.textContentStorage = textContentStorage
        documentScrollView.textDocumentView.textLayoutManager = textLayoutManager
        // - -
        documentScrollView.setupScrollView()
        documentScrollView.setupDocumentView()
        // - -
        return documentScrollView
    }

    override init(frame: NSRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setupScrollView() {
        wantsLayer = true
        hasVerticalScroller = true
        hasHorizontalScroller = true
        drawsBackground = true // Can be changed if needed
    }

    fileprivate func setupDocumentView() {
        documentView = textDocumentView
    }
}


#endif
