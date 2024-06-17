//
//  SelectedWalkActions.swift
//  WalkApp
//
//  Created by Kim Nordin on 2024-06-08.
//

import Foundation
import ReduxUI

struct SelectWalk: Action {
    let walk: Walk?
}

struct SelectedWalkToggleFirstSelect: Action {}

struct SelectedWalkToggleSecondSelect: Action {}

struct SelectedWalkUpdateFirstTime: Action {
    let date: Date
}

struct SelectedWalkUpdateSecondTime: Action {
    let date: Date
}

struct SelectedWalkUpdateDistance: Action {
    let distance: Double
}
