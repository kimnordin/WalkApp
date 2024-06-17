//
//  PendingWalkActions.swift
//  WalkApp
//
//  Created by Kim Nordin on 2024-06-14.
//

import Foundation
import ReduxUI

struct StartWalking: Action {
    let walk: Walk
}

struct StopWalking: Action {}

struct PendingWalkToggleFirstSelect: Action {}

struct PendingWalkToggleSecondSelect: Action {}

struct PendingWalkUpdateDistance: Action {
    let distance: Double
}
