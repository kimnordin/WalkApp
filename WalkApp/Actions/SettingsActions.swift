//
//  SettingsActions.swift
//  WalkApp
//
//  Created by Kim Nordin on 2022-08-03.
//

import ReduxUI
import SwiftUI

struct SelectSettingsButton: Action {
    let button: ButtonType?
}

struct SetButtonTitle: Action {
    let title: String
    let button: ButtonType
}

struct SetButtonColor: Action {
    let color: Color
    let button: ButtonType
}

struct RestoreDefaultSettings: Action {}
