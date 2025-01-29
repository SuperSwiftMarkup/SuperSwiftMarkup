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

extension SSRichTextView {
    internal func updateSelectionHighlights() {
        guard let textLayoutManager = self.textLayoutManager else { return }
        guard textLayoutManager.textSelections.isEmpty == false else {
            rootSelectionLayer.sublayers = nil
            return
        }
        rootSelectionLayer.sublayers = nil
        func process(textRange: NSTextRange) {
            textLayoutManager.enumerateTextSegments(
                in: textRange,
                type: .selection,
                options: []
            ) { ( textSegmentRange, textSegmentFrame, baselinePosition, _ ) in
                var highlightFrame = textSegmentFrame
                highlightFrame.origin.x += padding
                if highlightFrame.size.width > 0 {
                    // SELECTION HIGHLIGHT LAYER
                    let highlightSubLayer = SSRootLayer()
                    highlightSubLayer.backgroundColor = selectionColor.adaptiveColor.cgColor
                    highlightSubLayer.frame = highlightFrame
                    rootSelectionLayer.addSublayer(highlightSubLayer)
                } else {
                    // JUST THE CURSOR LAYER
                    let cursorSubLayer = TextDocumentCursorLayer()
                    cursorSubLayer.backgroundColor = caretColor.adaptiveColor.cgColor
                    cursorSubLayer.frame = highlightFrame.replacing(width: 2)
                    cursorSubLayer.setBlinkingCursorMode(enableBlinking: true)
                    rootSelectionLayer.addSublayer(cursorSubLayer)
                }
                return true // Keep going.
            }
        }
        for textSelection in textLayoutManager.textSelections {
            for textRange in textSelection.textRanges {
                process(textRange: textRange)
            }
        }
    }
    internal func updateContentSizeIfNeeded() {
        let currentHeight = bounds.height
        var height: CGFloat = 0
        guard let textLayoutManager = textLayoutManager else { return }
        textLayoutManager.ensureLayout(for: NSTextRange(location: textLayoutManager.documentRange.location))
        textLayoutManager.ensureLayout(for: NSTextRange(location: textLayoutManager.documentRange.endLocation))
        let usageBoundsForTextContainer = textLayoutManager.usageBoundsForTextContainer
        height = max(usageBoundsForTextContainer.height, enclosingScrollView?.contentSize.height ?? bounds.height)
        if abs(currentHeight - height) > 1e-10 {
            let contentSize = NSSize(width: bounds.width, height: height)
            setFrameSize(contentSize)
        }
    }
    internal func updateTextContainerSize() {
        if let textContainer = textLayoutManager?.textContainer, textContainer.size.width != bounds.width {
            textContainer.size = NSSize(width: bounds.size.width, height: 0)
            layer?.setNeedsLayout()
        }
    }
}

extension SSRichTextView: CALayerDelegate {
    public func layoutSublayers(of layer: CALayer) {
        assert(layer == self.layer)
        textLayoutManager?.textViewportLayoutController.layoutViewport()
        updateContentSizeIfNeeded()
        updateTextContainerSize()
    }
}

fileprivate final class TextDocumentCursorLayer: CALayer {
    private var timer: Timer?
    override class func defaultAction(forKey event: String) -> CAAction? {
        // Suppress default animation of opacity when adding comment bubbles.
        return NSNull()
    }
    func setBlinkingCursorMode(enableBlinking: Bool) {
        if enableBlinking, self.timer == nil {
            isHidden = false
            timer = Timer.scheduledTimer(
                withTimeInterval: 0.75,
                repeats: true,
                block: { [weak self] _ in self?.isHidden.toggle() }
            )
        } else if !enableBlinking {
            self.timer?.invalidate()
            self.timer = nil
        }
    }
}


