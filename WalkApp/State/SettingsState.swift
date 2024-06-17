//
//  SettingsState.swift
//  WalkApp
//
//  Created by Kim Nordin on 2022-08-03.
//

import SwiftUI
import ReduxUI

let defaultFirstTitle = "💦"
let defaultSecondTitle = "💩"
let defaultWalkColor = Color.walkOrange
let defaultFirstColor = Color.blue
let defaultSecondColor = Color.red

struct SettingsState: StateType {
    var firstTitle: String = defaultFirstTitle
    var secondTitle: String = defaultSecondTitle
    var walkColor: Color = defaultWalkColor
    var firstColor: Color = defaultFirstColor
    var secondColor: Color = defaultSecondColor
    var selectedButton: ButtonType?
}

enum ButtonType: Identifiable {
    var id: Self { return self }
    
    case walk, first, second, none
}
