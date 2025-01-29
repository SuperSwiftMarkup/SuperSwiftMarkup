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

#if os(macOS) && !targetEnvironment(macCatalyst)
@_exported import AppKit
public typealias XFont = NSFont
public typealias XFontDescriptor = NSFontDescriptor
public typealias XColor = NSColor
public typealias XView = NSView
#elseif os(iOS) || os(visionOS)
@_exported import UIKit
public typealias XFont = UIFont
public typealias XFontDescriptor = UIFontDescriptor
public typealias XColor = UIColor
public typealias XView = UIView
#endif

//public typealias XUnderlineStyle = NSUnderlineStyle
//public typealias XMutableParagraphStyle = NSMutableParagraphStyle
//public typealias XTextTab = NSTextTab
//public typealias XTextAlignment = NSTextAlignment

//public typealias XTextLayoutManager = NSTextLayoutManager
//public typealias XTextLayoutManagerDelegate = NSTextLayoutManagerDelegate
//public typealias XTextLocation  = NSTextLocation
//public typealias XTextElement  = NSTextElement
//public typealias XTextLayoutFragment  = NSTextLayoutFragment
//public typealias XTextViewportLayoutControllerDelegate = NSTextViewportLayoutControllerDelegate
//public typealias XTextViewportLayoutController = NSTextViewportLayoutController

