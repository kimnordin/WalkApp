//
//  WalkListView.swift
//  WalkApp
//
//  Created by Kim Nordin on 2020-10-17.
//

import SwiftUI
import ReduxUI

struct WalkListView: View {
    @EnvironmentObject private var store: Store<AppState>
    @State private var walks: [Walk] = []
    @State private var selectedWalk: Walk?
    
    var body: some View {
        NavigationView {
            VStack {
                if walks.isEmpty {
                    Text("No Walks Made")
                        .frame(maxHeight: .infinity)
                } else {
                    List {
                        ForEach(walks) { walk in
                            WalkRowView(walk: walk)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    SelectWalk(walk: walk).dispatchFromMain()
                                }
                        }
                    }
                }
                Spacer()
                WalkSectionView()
            }
            .navigationBarTitle(Text("Walks"))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Settings") {
                        NavigateTo(destination: .settings).dispatchFromMain()
                    }
                }
            }
        }
        .onReceive(store.$state) {
            newState($0)
        }
        .sheet(item: $selectedWalk, onDismiss: {
            SelectWalk(walk: nil).dispatchFromMain()
        }) { _ in
            SheetContentView(item: $selectedWalk) {
                EditWalkView()
            }
        }
    }
}

extension WalkListView: StoreSubscriber {
    func newState(_ state: AppState) {
        walks = state.walksState.walks
        selectedWalk = state.selectedWalkState.selectedWalk
    }
}

struct WalkListView_Previews: PreviewProvider {
    static var previews: some View {
        WalkListView()
            .environmentObject(store)
    }
}
