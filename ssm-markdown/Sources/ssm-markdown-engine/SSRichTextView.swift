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

import Foundation
import SSMUtilities
import ssm_system_utilities

public final class SSRichTextView: XView {
    internal var textLayoutManager: NSTextLayoutManager? {
        willSet {
            if let tlm = textLayoutManager {
                tlm.delegate = nil
                tlm.textViewportLayoutController.delegate = nil
            }
        }
        didSet {
            if let tlm = textLayoutManager {
                tlm.delegate = self
                tlm.textViewportLayoutController.delegate = self
            }
            updateContentSizeIfNeeded()
            updateTextContainerSize()
            layer!.setNeedsLayout()
        }
    }
    internal var textContentStorage: NSTextContentStorage?
    
    // MARK: - INITIALIZATION & DE-INITIALIZATION -
    public override init(frame: CGRect) {
        print("SSRichTextView: INIT CALLED", frame.debugDescription)
        fragmentLayerMap = .weakToWeakObjects()
        super.init(frame: frame)
        // - -
        wantsLayer = true
//        layer!.backgroundColor = NSColor.red.withAlphaComponent(0.05).cgColor
        layer!.addSublayer(rootContentLayer)
        layer!.addSublayer(rootSelectionLayer)
        autoresizingMask = [ .width, .height ]
        postsBoundsChangedNotifications = true
        postsFrameChangedNotifications = true
//        // - -
        let textLayoutManager = NSTextLayoutManager()
        let textContentStorage = NSTextContentStorage()
        textContentStorage.textStorage!.setAttributedString(NSAttributedString(
            string: "Hello World!\nHello World!"
//            attributes: [
//                .foregroundColor: XColor.red,
//                .font: XFont.systemFont(ofSize: 20, weight: .semibold),
//            ]
        ))
        textContentStorage.addTextLayoutManager(textLayoutManager)
        textContentStorage.primaryTextLayoutManager = textLayoutManager
        textLayoutManager.delegate = self
        textLayoutManager.textViewportLayoutController.delegate = self
        self.textLayoutManager = textLayoutManager
        self.textContentStorage = textContentStorage
        updateContentSizeIfNeeded()
        updateTextContainerSize()
        layer!.setNeedsLayout()
    }
    
    public func update() {
        self.needsLayout = true
        self.needsDisplay = true
        layer!.setNeedsLayout()
        layer!.setNeedsDisplay()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
       if let observer = boundsDidChangeObserver {
           NotificationCenter.default.removeObserver(observer)
       }
    }
    
    // MARK: - HANDLE STUPID LEGACY STUFF -
    public override var isFlipped: Bool { true }
    
    // MARK: - NSResponder -
    public override var acceptsFirstResponder: Bool { true }
    
    // MARK: - CONTENT RENDERING -
    internal var rootContentLayer: SSRootLayer = SSRootLayer()
    internal var rootSelectionLayer: SSRootLayer = SSRootLayer()
    internal var fragmentLayerMap: NSMapTable<NSTextLayoutFragment, SSTextFragmentLayer>
    internal var padding: CGFloat = 5.0
    
    // MARK: - MISCELLANEOUS -
    internal var boundsDidChangeObserver: Any? = nil
    internal var focusSelectionRequest: FocusSelectionRequest? = nil {
        didSet {
            if focusSelectionRequest != nil {
                needsLayout = true
            }
        }
    }
    internal enum FocusSelectionRequest {
        case scrollTo(ScrollDirection)
        internal enum ScrollDirection {
            case up
            case down
        }
    }
    // TODO: MOVE ELSEWHERE -
    var selectionColor: SSColorMap {
        SSColorMap(
            light: .systemBlue.withAlphaComponent(0.2),
            dark: .systemBlue.withAlphaComponent(0.5)
        )
    }
    var caretColor: SSColorMap {
        SSColorMap(
            light: .systemBlue,
            dark: .systemBlue
        )
    }
    
    // MARK: - Responsive scrolling -
    override public class var isCompatibleWithResponsiveScrolling: Bool { true }
    override public func prepareContent(in rect: NSRect) {
        layer!.setNeedsLayout()
        super.prepareContent(in: rect)
    }
    // TODO: UPDATE THIS CODE
    override public func centerSelectionInVisibleArea(_ sender: Any?) {
        if !textLayoutManager!.textSelections.isEmpty {
            let viewportOffset = textLayoutManager!.textViewportLayoutController.relocateViewport(
                to: textLayoutManager!.textSelections[0].textRanges[0].location
            )
            scroll(CGPoint(x: 0, y: viewportOffset))
        }
    }
}
