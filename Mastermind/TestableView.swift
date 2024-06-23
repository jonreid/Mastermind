// TestableView by Jon Reid, https://qualitycoding.org
// Copyright 2024 Jonathan M. Reid. https://github.com/jonreid/TestableView/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

import SwiftUI

protocol ViewInspectorHook {
    var viewInspectorHook: ((Self) -> Void)? { get set }
}

typealias TestableView = View & ViewInspectorHook
