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

extension OptionSet {
    internal func including(optional newMember: Self.Element, ifTrue condition: Bool) -> Self {
        if condition {
            var copy = self
            copy.insert(newMember)
            return copy
        }
        return self
    }
    internal func including(_ newMember: Self.Element) -> Self {
        var copy = self
        copy.insert(newMember)
        return copy
    }
}

