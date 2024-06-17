//
//  FirstButtonView.swift
//  WalkApp
//
//  Created by Kim Nordin on 2022-07-10.
//

import SwiftUI
import ReduxUI

struct FirstButtonView: View {
    @EnvironmentObject private var store: Store<AppState>
    @State private var walk: Walk?

    var body: some View {
        VStack {
            if let walk = walk {
                Button {
                    PendingWalkToggleFirstSelect().dispatchFromMain()
                } label: {
                    Text(store.state.settingsState.firstTitle)
                        .walkActionButton(selected: walk.firstSelect)
                }
                .walkSelectionButton(selected: walk.firstSelect, color: store.state.settingsState.firstColor)
            }
        }
        .onReceive(store.$state) {
            newState($0.pendingWalkState)
        }
    }
}

extension FirstButtonView: StoreSubscriber {
    func newState(_ state: PendingWalkState) {
        walk = state.pendingWalk
    }
}

struct FirstButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FirstButtonView()
            .environmentObject(store)
    }
}
