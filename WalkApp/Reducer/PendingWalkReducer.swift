//
//  PendingWalkReducer.swift
//  WalkApp
//
//  Created by Kim Nordin on 2024-06-14.
//

import ReduxUI

func pendingWalkReducer(action: Action, state: PendingWalkState?) -> PendingWalkState {
    var state = state ?? initialPendingWalkState()

    switch action {
    case let action as StartWalking:
        state.pendingWalk = action.walk
    case is StopWalking:
        state.pendingWalk = nil
    case is PendingWalkToggleFirstSelect:
        state.pendingWalk?.firstSelect.toggle()
    case is PendingWalkToggleSecondSelect:
        state.pendingWalk?.secondSelect.toggle()
    case let action as PendingWalkUpdateDistance:
        state.pendingWalk?.distance = action.distance
    default: break
    }

    return state
}

func initialPendingWalkState() -> PendingWalkState {
    return PendingWalkState()
}
