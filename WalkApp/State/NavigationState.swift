//
//  NavigationState.swift
//  WalkApp
//
//  Created by Kim Nordin on 2022-03-28.
//

import ReduxUI

struct NavigationState: StateType {
    var command: Command
    var destination: NavigationDestination
    var history: [NavigationDestination]
}

enum Command {
    case goForward
    case goBack
    case goBackTo
}

enum NavigationDestination {
    case walks, settings
}
