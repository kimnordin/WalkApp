//
//  EditWalkSecondButtonView.swift
//  WalkApp
//
//  Created by Kim Nordin on 2022-08-07.
//

import SwiftUI
import ReduxUI

struct EditWalkSecondButtonView: View {
    @EnvironmentObject private var store: Store<AppState>
    @State private var walk: Walk?

    var body: some View {
        VStack {
            if let walk = store.state.selectedWalkState.selectedWalk {
                Button  {
                    SelectedWalkToggleSecondSelect().dispatchFromMain()
                } label: {
                    Text(store.state.settingsState.secondTitle)
                        .walkActionButton(selected: walk.secondSelect)
                }
                .walkSelectionButton(selected: walk.secondSelect, color: store.state.settingsState.secondColor)
            }
        }
        .onReceive(store.$state) {
            newState($0.selectedWalkState)
        }
    }
}

extension EditWalkSecondButtonView: StoreSubscriber {
    func newState(_ state: SelectedWalkState) {
        walk = state.selectedWalk
    }
}

struct EditWalkSecondButtonView_Previews: PreviewProvider {
    static var previews: some View {
        EditWalkSecondButtonView()
            .environmentObject(store)
    }
}
