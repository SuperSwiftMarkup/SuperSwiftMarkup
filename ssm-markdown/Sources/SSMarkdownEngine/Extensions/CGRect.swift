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

import CoreGraphics

#if os(macOS) && !targetEnvironment(macCatalyst)
import struct AppKit.NSEdgeInsets
#elseif os(iOS) || os(visionOS)
import struct UIKit.UIEdgeInsets
#endif

extension CGRect {
    internal func replacing(width: CGFloat) -> CGRect {
        CGRect(origin: origin, size: CGSize(width: width, height: size.height))
    }
    func inset(by edgeInsets: EdgeInsets) -> CGRect {
        var result = self
        result.origin.x += edgeInsets.left
        result.origin.y += edgeInsets.top
        result.size.width -= edgeInsets.left + edgeInsets.right
        result.size.height -= edgeInsets.top + edgeInsets.bottom
        return result
    }
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
    typealias EdgeInsets = NSEdgeInsets
#else
    typealias EdgeInsets = UIEdgeInsets
#endif
}

extension CGRect {
    internal func mapOrigin(apply: @escaping (CGPoint) -> CGPoint) -> CGRect {
        CGRect(origin: apply(self.origin), size: self.size)
    }
    internal func mapSize(apply: @escaping (CGSize) -> CGSize) -> CGRect {
        CGRect(origin: self.origin, size: apply(self.size))
    }
    internal func mapWidth(apply: @escaping (CGFloat) -> CGFloat) -> CGRect {
        CGRect(origin: self.origin, size: .init(width: apply(self.size.width), height: self.size.height))
    }
}

