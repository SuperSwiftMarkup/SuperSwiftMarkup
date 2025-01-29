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
    private var textDocumentView: SSRichTextView
    
    override init(frame: NSRect) {
        textDocumentView = SSRichTextView(frame: frame)
        super.init(frame: frame)
        setupScrollView()
        setupDocumentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SSRichTextScrollView {
    private func setupScrollView() {
        wantsLayer = true
        hasVerticalScroller = true
        hasHorizontalScroller = true
        drawsBackground = true // Can be changed if needed
    }

    private func setupDocumentView() {
        documentView = textDocumentView
        
        // Ensure document view resizes properly
        textDocumentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textDocumentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textDocumentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textDocumentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            textDocumentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

#endif
