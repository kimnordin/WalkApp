//
//  AppReducer.swift
//  WalkApp
//
//  Created by Kim Nordin on 2022-03-28.
//

import ReduxUI

func appReducer(action: Action, state: AppState?) -> AppState {
    let state = state ?? initialAppState()
    
    return AppState(navigationState: navigationReducer(action: action, state: state.navigationState), settingsState: settingsReducer(action: action, state: state.settingsState), walksState: walksReducer(action: action, state: state.walksState), selectedWalkState: selectedWalkReducer(action: action, state: state.selectedWalkState), pendingWalkState: pendingWalkReducer(action: action, state: state.pendingWalkState))
}

func initialAppState() -> AppState {
    return AppState(navigationState: initialNavigationState(), settingsState: initialSettingsState(), walksState: initialWalksState(), selectedWalkState: initialSelectedWalkState(), pendingWalkState: initialPendingWalkState())
}
