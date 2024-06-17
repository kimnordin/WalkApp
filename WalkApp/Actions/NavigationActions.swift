//
//  NavigationActions.swift
//  WalkApp
//
//  Created by Kim Nordin on 2022-03-28.
//

import ReduxUI

struct NavigateTo: Action {
    let destination: NavigationDestination
}

struct NavigateBack: Action {}

struct NavigateBackTo: Action {
    let destination: NavigationDestination
}
