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
import enum SwiftUI.ColorScheme

#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit
#elseif os(iOS) || os(visionOS)
import UIKit
#endif

public enum SSColorSchemeMode: Equatable {
    case light, dark
}

extension SSColorSchemeMode {
    init(from mode: SwiftUI.ColorScheme, `default`: SSColorSchemeMode) {
        switch mode {
        case .light: self = .light
        case .dark: self = .dark
        @unknown default: self = `default`
        }
    }
}

#if os(macOS) && !targetEnvironment(macCatalyst)
extension SSColorSchemeMode {
    fileprivate static func isDarkMode(view: NSView) -> Bool {
        view.effectiveAppearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
    }
    public static func detectColorScheme(view: NSView) -> SSColorSchemeMode {
        if isDarkMode(view: view) {
            return .dark
        }
        return .light
    }
}
#endif

#if os(iOS) || os(visionOS)
extension SSColorSchemeMode {
    fileprivate static func isDarkMode(view: UIView) -> Bool {
        if #available(iOS 13.0, *) {
            return view.traitCollection.userInterfaceStyle == .dark
        }
        else {
            return false
        }
    }
    public static func detectColorScheme(view: UIView) -> SSColorSchemeMode {
        if isDarkMode(view: view) {
            return .dark
        }
        return .light
    }
}
#endif

