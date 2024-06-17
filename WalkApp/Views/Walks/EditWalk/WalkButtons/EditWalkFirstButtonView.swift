//
//  EditWalkFirstButtonView.swift
//  WalkApp
//
//  Created by Kim Nordin on 2022-08-07.
//

import SwiftUI
import ReduxUI

struct EditWalkFirstButtonView: View {
    @EnvironmentObject private var store: Store<AppState>
    @State private var walk: Walk?

    var body: some View {
        VStack {
            if let walk = store.state.selectedWalkState.selectedWalk {
                Button  {
                    SelectedWalkToggleFirstSelect().dispatchFromMain()
                } label: {
                    Text(store.state.settingsState.firstTitle)
                        .walkActionButton(selected: walk.firstSelect)
                }
                .walkSelectionButton(selected: walk.firstSelect, color: store.state.settingsState.firstColor)
            }
        }
        .onReceive(store.$state) {
            newState($0.selectedWalkState)
        }
    }
}

extension EditWalkFirstButtonView: StoreSubscriber {
    func newState(_ state: SelectedWalkState) {
        walk = state.selectedWalk
    }
}

struct EditWalkFirstButtonView_Previews: PreviewProvider {
    static var previews: some View {
        EditWalkFirstButtonView()
            .environmentObject(store)
    }
}
