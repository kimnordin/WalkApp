//
//  SelectedWalkReducer.swift
//  WalkApp
//
//  Created by Kim Nordin on 2024-06-08.
//

import ReduxUI

func selectedWalkReducer(action: Action, state: SelectedWalkState?) -> SelectedWalkState {
    var state = state ?? initialSelectedWalkState()

    switch action {
    case let action as SelectWalk:
        state.selectedWalk = action.walk
    case is SelectedWalkToggleFirstSelect:
        state.selectedWalk?.firstSelect.toggle()
    case is SelectedWalkToggleSecondSelect:
        state.selectedWalk?.secondSelect.toggle()
    case let action as SelectedWalkUpdateFirstTime:
        state.selectedWalk?.firstTime = action.date
    case let action as SelectedWalkUpdateSecondTime:
        state.selectedWalk?.secondTime = action.date
    case let action as SelectedWalkUpdateDistance:
        state.selectedWalk?.distance = action.distance
    default: break
    }

    return state
}

func initialSelectedWalkState() -> SelectedWalkState {
    return SelectedWalkState()
}
