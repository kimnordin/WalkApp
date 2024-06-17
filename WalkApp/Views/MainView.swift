//
//  MainView.swift
//  WalkApp
//
//  Created by Kim Nordin on 2022-08-04.
//

import SwiftUI
import ReduxUI

struct MainView: View {
    @EnvironmentObject private var store: Store<AppState>
    @State private var destination: NavigationDestination = .walks
    
    var body: some View {
        RouterView
        .onReceive(store.$state) {
            newState($0.navigationState)
        }
    }
    
    @ViewBuilder private var RouterView: some View {
        switch store.state.navigationState.destination {
        case .walks:
            WalkListView()
        case .settings:
            SettingsView()
        }
    }
}

extension MainView: StoreSubscriber {
    func newState(_ state: NavigationState) {
        switch state.destination {
        case .walks:
            destination = .walks
        case .settings:
            destination = .settings
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(store)
    }
}
