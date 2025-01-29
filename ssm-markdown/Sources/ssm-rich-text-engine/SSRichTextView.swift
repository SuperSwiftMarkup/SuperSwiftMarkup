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
    internal var textLayoutManager: NSTextLayoutManager = NSTextLayoutManager() {
        willSet {
            textLayoutManager.delegate = nil
            textLayoutManager.textViewportLayoutController.delegate = nil
        }
        didSet {
            textLayoutManager.delegate = self
            textLayoutManager.textViewportLayoutController.delegate = self
            updateContentSizeIfNeeded()
            updateTextContainerSize()
            layer!.setNeedsLayout()
        }
    }
    
    internal var textContentStorage: NSTextContentStorage = NSTextContentStorage() {
        didSet {
            textContentStorage.textStorage?.setAttributedString(NSAttributedString(string: "Hello World!"))
            textContentStorage.addTextLayoutManager(textLayoutManager)
            textContentStorage.primaryTextLayoutManager = textLayoutManager
            updateContentSizeIfNeeded()
        }
    }
    
    // MARK: - INITIALIZATION & DE-INITIALIZATION -
    override init(frame: CGRect) {
        fragmentLayerMap = .weakToWeakObjects()
        super.init(frame: frame)
        // - -
        wantsLayer = true
        layer?.addSublayer(rootContentLayer)
        layer?.addSublayer(rootSelectionLayer)
        fragmentLayerMap = NSMapTable.weakToWeakObjects()
        autoresizingMask = [ .width, .height ]
        postsBoundsChangedNotifications = true
        postsFrameChangedNotifications = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
       if let observer = boundsDidChangeObserver {
           NotificationCenter.default.removeObserver(observer)
       }
    }
    
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
}
