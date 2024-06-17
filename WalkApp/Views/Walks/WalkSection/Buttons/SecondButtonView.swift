//
//  SecondButtonView.swift
//  WalkApp
//
//  Created by Kim Nordin on 2022-07-10.
//

import SwiftUI
import ReduxUI

struct SecondButtonView: View {
    @EnvironmentObject private var store: Store<AppState>
    @State private var walk: Walk?

    var body: some View {
        VStack {
            if let walk = walk {
                Button {
                    PendingWalkToggleSecondSelect().dispatchFromMain()
                } label: {
                    Text(store.state.settingsState.secondTitle)
                        .walkActionButton(selected: walk.secondSelect)
                }
                .walkSelectionButton(selected: walk.secondSelect, color: store.state.settingsState.secondColor)
            }
        }
        .onReceive(store.$state) {
            newState($0.pendingWalkState)
        }
    }
}

extension SecondButtonView: StoreSubscriber {
    func newState(_ state: PendingWalkState) {
        walk = state.pendingWalk
    }
}
struct SSecondButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SecondButtonView()
            .environmentObject(store)
    }
}
