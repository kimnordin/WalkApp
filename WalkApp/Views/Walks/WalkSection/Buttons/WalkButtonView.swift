//
//  WalkButtonView.swift
//  WalkApp
//
//  Created by Kim Nordin on 2022-07-10.
//

import SwiftUI
import ReduxUI

struct WalkButtonView: View {
    @EnvironmentObject private var store: Store<AppState>
    @State private var walk: Walk?
    
    var body: some View {
        VStack {
            let walking = walk != nil
            Button {
                if walking {
                    StopWalking().dispatchFromMain()
                } else {
                    StartWalking(walk: Walk(firstTime: Date())).dispatchFromMain()
                }
            } label: {
                Text(walking ? "Stop" : "Walk")
                    .walkActionButton(selected: walking, unselectedColor: store.state.settingsState.walkColor, width: 120)
            }
            .walkSelectionButton(selected: walking, color: store.state.settingsState.walkColor)
        }
        .onReceive(store.$state) {
            newState($0.pendingWalkState)
        }
    }
}

extension WalkButtonView: StoreSubscriber {
    func newState(_ state: PendingWalkState) {
        walk = state.pendingWalk
    }
}

struct WalkButtonView_Previews: PreviewProvider {
    static var previews: some View {
        WalkButtonView()
            .environmentObject(store)
    }
}
