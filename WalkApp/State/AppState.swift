//
//  AppState.swift
//  WalkApp
//
//  Created by Kim Nordin on 2022-02-17.
//

import ReduxUI

struct AppState: StateType {
    var navigationState: NavigationState = initialNavigationState()
    var settingsState: SettingsState = initialSettingsState()
    var walksState: WalksState = initialWalksState()
    var selectedWalkState: SelectedWalkState = initialSelectedWalkState()
    var pendingWalkState: PendingWalkState = initialPendingWalkState()
}
