//
//  WalkAppApp.swift
//  WalkApp
//
//  Created by Kim Nordin on 2024-06-17.
//

import SwiftUI
import ReduxUI

let store = Store<AppState>(state: initialAppState(), reducer: appReducer, middlewares: [walksMiddleware, pendingWalkMiddleware])

@main
struct WalkAppApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .accentColor(Color.dogOrange)
                .environmentObject(store)
        }
    }
}
