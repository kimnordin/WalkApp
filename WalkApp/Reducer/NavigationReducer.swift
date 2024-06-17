//
//  NavigationReducer.swift
//  WalkApp
//
//  Created by Kim Nordin on 2022-03-28.
//

import ReduxUI

func navigationReducer(action: Action, state: NavigationState?) -> NavigationState {
    var state = state ?? initialNavigationState()
    
    switch action {
    case let action as NavigateTo:
        if state.destination != action.destination {
            state.history.append(state.destination)
            state.destination = action.destination
            state.command = .goForward
        }
    case is NavigateBack:
        if let lastRoute = state.history.popLast() {
            state.destination = lastRoute
            state.command = .goBack
        }
        if state.history.isEmpty {
            state.destination = .walks
            state.command = .goBack
        }
    case let action as NavigateBackTo:
        if state.destination != action.destination && state.history.contains(action.destination) {
            state.destination = action.destination
            state.command = .goBackTo
        }
    default: break
    }
    
    return state
}

func initialNavigationState() -> NavigationState {
    return NavigationState(command: .goForward, destination: .walks, history: [NavigationDestination]())
}
