//
//  SettingsReducer.swift
//  WalkApp
//
//  Created by Kim Nordin on 2022-08-03.
//

import ReduxUI

func settingsReducer(action: Action, state: SettingsState?) -> SettingsState {
    var state = state ?? initialSettingsState()
    
    switch action {
    case let action as SelectSettingsButton:
        state.selectedButton = action.button
    case let action as SetButtonTitle:
        switch action.button {
        case .first:
            state.firstTitle = action.title
        case .second:
            state.secondTitle = action.title
        default: break
        }
    case let action as SetButtonColor:
        switch action.button {
        case .walk:
            state.walkColor = action.color
        case .first:
            state.firstColor = action.color
        case .second:
            state.secondColor = action.color
        default: break
        }
    case is RestoreDefaultSettings:
        state = initialSettingsState()
    default: break
    }
    
    return state
}

func initialSettingsState() -> SettingsState {
    return SettingsState()
}
