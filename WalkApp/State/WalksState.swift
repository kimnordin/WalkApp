//
//  WalksState.swift
//  WalkApp
//
//  Created by Kim Nordin on 2022-12-06.
//

import ReduxUI

struct WalksState {
    var walks = [Walk]()
    let pedometer = Pedometer()
}

extension WalksState: StateType {
    static func == (lhs: WalksState, rhs: WalksState) -> Bool {
        return lhs.walks == rhs.walks
    }
}
