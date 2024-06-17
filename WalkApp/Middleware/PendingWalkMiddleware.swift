//
//  PendingWalkMiddleware.swift
//  WalkApp
//
//  Created by Kim Nordin on 2024-06-14.
//

import Foundation
import ReduxUI

func pendingWalkMiddleware(_ dispatch: @escaping Dispatch, _ state: @escaping () -> AppState?) -> (@escaping Dispatch) -> Dispatch {
    return { next in
        return { action in
            if let state = state() {
                switch action {
                case let action as StartWalking:
                    pedometer.startPedometer(from: action.walk.firstTime) { distance in
                        dispatch(PendingWalkUpdateDistance(distance: distance))
                    }
                case is StopWalking:
                    guard let pendingWalk = state.pendingWalkState.pendingWalk else { break }
                    let walk = Walk(firstTime: pendingWalk.firstTime, secondTime: Date(), distance: pendingWalk.distance, firstSelect: pendingWalk.firstSelect, secondSelect: pendingWalk.secondSelect)
                    dispatch(AddWalk(walk: walk))
                default:
                    break
                }
            }
            next(action)
        }
    }
}

