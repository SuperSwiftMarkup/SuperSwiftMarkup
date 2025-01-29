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
import ssm_system_utilities

internal final class SSTextFragmentLayer: CALayer {
    private var layoutFragment: NSTextLayoutFragment
    private var padding: CGFloat
    private weak var parent: SSRichTextView?
    init(layoutFragment: NSTextLayoutFragment, padding: CGFloat, parent: SSRichTextView?) {
//        self.layoutFragment = layoutFragment
//        self.padding = padding
        self.layoutFragment = layoutFragment
        self.padding = padding
        self.parent = parent
        super.init()
        masksToBounds = false
        contentsScale = 2
        updateGeometry()
        setNeedsDisplay()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SSTextFragmentLayer {
    public func updateGeometry() {
        setGeometryToFullWidth()
    }
    public override class func defaultAction(forKey: String) -> CAAction? {
        // Suppress default opacity animations.
        return NSNull()
    }
    public override func draw(in context: CGContext) {
        layoutFragment.draw(
            at: .init(
                x: layoutFragment.layoutFragmentFrame.origin.x + padding,
                y: 0
            ),
            in: context
        )
    }
}


extension SSTextFragmentLayer {
    private func setGeometryToFullWidth() {
        bounds = CGRect(
            origin: CGPoint(
                x: 0,
                y: layoutFragment.renderingSurfaceBounds.origin.y
            ),
            size: CGSize(
                width: max(layoutFragment.renderingSurfaceBounds.width, parent?.bounds.width ?? 0),
                height: layoutFragment.renderingSurfaceBounds.height
            )
        )
        // The (0, 0) point in layer space should be the anchor point.
        anchorPoint = CGPoint(x: -bounds.origin.x / bounds.size.width, y: -bounds.origin.y / bounds.size.height)
        position = layoutFragment.layoutFragmentFrame.origin.mapX(apply: { _ in 0 })
        // On macOS 14 and iOS 17, NSTextLayoutFragment.renderingSurfaceBounds is properly relative to the NSTextLayoutFragment's
        // interior coordinate system, and so this sample no longer needs the inconsistent x origin adjustment.
        if #unavailable(iOS 17, macOS 14) {
            bounds.origin = bounds.origin.mapX(apply: { $0 + position.x })
        }
    }
}
