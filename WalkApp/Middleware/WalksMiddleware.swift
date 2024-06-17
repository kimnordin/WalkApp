//
//  WalksMiddleware.swift
//  WalkApp
//
//  Created by Kim Nordin on 2024-06-09.
//

import ReduxUI

func walksMiddleware(_ dispatch: @escaping Dispatch, _ state: @escaping () -> AppState?) -> (@escaping Dispatch) -> Dispatch {
    return { next in
        return { action in
            next(action)
            if let state = state() {
                switch action {
                case is SelectedWalkToggleFirstSelect, is SelectedWalkToggleSecondSelect, is SelectedWalkUpdateDistance:
                    guard let walk = state.selectedWalkState.selectedWalk else { break }
                    dispatch(UpdateWalk(walk: walk))
                case let action as SelectedWalkUpdateFirstTime:
                    guard let walk = state.selectedWalkState.selectedWalk else { break }
                    pedometer.countSteps(from: action.date, to: walk.secondTime) { distance in
                        dispatch(SelectedWalkUpdateDistance(distance: distance))
                    }
                case let action as SelectedWalkUpdateSecondTime:
                    guard let walk = state.selectedWalkState.selectedWalk else { break }
                    pedometer.countSteps(from: walk.firstTime, to: action.date) { distance in
                        dispatch(SelectedWalkUpdateDistance(distance: distance))
                    }
                default: break
                }
            }
        }
    }
}
