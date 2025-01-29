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

extension SSRichTextView {
    public override func viewDidEndLiveResize() {
        super.viewDidEndLiveResize()
        adjustViewportOffsetIfNeeded()
        updateContentSizeIfNeeded()
    }
    public override func viewWillMove(toSuperview newSuperview: NSView?) {
        if let clipView = scrollView?.contentView {
            NotificationCenter.default.removeObserver(self, name: NSView.boundsDidChangeNotification, object: clipView)
        }
        super.viewWillMove(toSuperview: newSuperview)
    }
    
    public override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        if let clipView = scrollView?.contentView {
            boundsDidChangeObserver = NotificationCenter.default.addObserver(
                forName: NSView.boundsDidChangeNotification,
                object: clipView,
                queue: nil
            ) { [weak self] notification in
                self!.layer?.setNeedsLayout()
            }
        }
    }

    public override func setFrameSize(_ newSize: NSSize) {
        super.setFrameSize(newSize)
        updateTextContainerSize()
    }
    public override var intrinsicContentSize: NSSize {
        textLayoutManager.usageBoundsForTextContainer.size
    }
    public override func layout() {
        super.layout()
        if inLiveResize {
            return Throttler.throttle(0.05, identifier: "layoutViewport", option: .ensureLast) { [weak self] in
                guard let self else { return }
                self._layout()
            }
        }
        _layout()
    }
}

// TODO: CLEANUP THE FOLLOWING INTERNAL HELPERS -

extension SSRichTextView {
    fileprivate func _layout() {
        layoutViewport()
        if let focusSelectionRequest = focusSelectionRequest {
            switch focusSelectionRequest {
            case .scrollTo(.up):
                let targetRange = textLayoutManager.textSelections
                    .flatMap(\.textRanges)
                    .flatMap { [ NSTextRange(location: $0.location), NSTextRange(location: $0.endLocation) ] }
                    .sorted(by: { $0.location < $1.location })
                    .first
                if let textRange = targetRange {
                    scrollToVisible(textRange, type: .standard)
                }
            case .scrollTo(.down):
                let targetRange = textLayoutManager.textSelections
                    .flatMap(\.textRanges)
                    .flatMap { [ NSTextRange(location: $0.location), NSTextRange(location: $0.endLocation) ] }
                    .sorted(by: { $0.location < $1.location })
                    .last
                if let textRange = targetRange {
                    scrollToVisible(textRange, type: .standard)
                }
            }
        }
        focusSelectionRequest = nil
    }
    fileprivate func layoutViewport() {
        // layoutViewport does not handle properly layout range
        // for far jump it tries to layout everything starting at location 0
        // even though viewport range is properly calculated.
        // No known workaround.
        textLayoutManager.textViewportLayoutController.layoutViewport()
    }
}

extension SSRichTextView {
    fileprivate var scrollView: NSScrollView? {
        guard let result = enclosingScrollView else {
            print("MISSING: enclosingScrollView")
            return nil
        }
        if result.documentView == self {
            return result
        }
        print("NOTE: NO SCROLL VIEW")
        return nil
    }
}

extension SSRichTextView {
    fileprivate func scrollToVisible(_ selectionTextRange: NSTextRange, type: NSTextLayoutManager.SegmentType) {
        guard var rect = textLayoutManager.textSegmentFrame(in: selectionTextRange, type: type) else {
            return
        }
        let textContainer = textLayoutManager.textContainer!

        if rect.width.isZero {
            // add padding around the point to ensure the visibility the segment
            // since the width of the segment is 0 for a selection
            rect = rect.inset(by: .init(top: 0, left: -textContainer.lineFragmentPadding, bottom: 0, right: -textContainer.lineFragmentPadding))
        }

        // scroll to visible IN clip view (ignoring gutter view overlay)
        // adjust rect to mimick it's size to include gutter overlay
//        rect.origin.x -= gutterView?.frame.width ?? 0
//        rect.size.width += gutterView?.frame.width ?? 0
        let _ = scrollToVisible(rect)
    }
}

// TODO: MOVE ELSEWHERE
extension NSTextLayoutManager {
    /// A text segment is both logically and visually contiguous portion of the text content inside a line fragment.
    /// Text segment is a logically and visually contiguous portion of the text content inside a line fragment that you specify with a single text range.
    /// The framework enumerates the segments visually from left to right.
    fileprivate func textSegmentFrame(
        in textRange: NSTextRange,
        type: NSTextLayoutManager.SegmentType,
        options: SegmentOptions = [.upstreamAffinity, .rangeNotRequired]
    ) -> CGRect? {
        var result: CGRect? = nil
        // .upstreamAffinity: When specified, the segment is placed based on the upstream affinity for an empty range.
        //
        // In the context of text editing, upstream affinity means that the selection is biased towards the preceding or earlier portion of the text,
        // while downstream affinity means that the selection is biased towards the following or later portion of the text. The affinity helps determine
        // the behavior of the text selection when the text is modified or manipulated.

        // FB15131180: Extra line fragment frame is not correct, that affects enumerateTextSegments as well.
        enumerateTextSegments(in: textRange, type: type, options: options) { textSegmentRange, textSegmentFrame, baselinePosition, textContainer -> Bool in
            result = result?.union(textSegmentFrame) ?? textSegmentFrame
            return true
        }
        return result
    }
}


#endif


fileprivate extension NSTextLocation {
    static func < ( left: Self, right: Self ) -> Bool { left.compare(right) == .orderedAscending }
}
