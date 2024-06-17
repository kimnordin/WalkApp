//
//  WalksReducer.swift
//  WalkApp
//
//  Created by Kim Nordin on 2024-06-08.
//

import ReduxUI

func walksReducer(action: Action, state: WalksState?) -> WalksState {
    var state = state ?? initialWalksState()

    switch action {
    case let action as AddWalk:
        state.walks.append(action.walk)
    case let action as UpdateWalk:
        if let index = state.walks.firstIndex(where: { $0.id == action.walk.id }) {
            state.walks[index] = action.walk
        }
    default: break
    }

    return state
}

func initialWalksState() -> WalksState {
    return WalksState()
}
