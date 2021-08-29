//
//  WalkAppApp.swift
//  WalkApp
//
//  Created by Kim Nordin on 2021-08-25.
//

import SwiftUI

@main
struct WalkAppApp: App {
    @StateObject private var dogData = DogArray()
    @StateObject private var user = User()
    var body: some Scene {
        WindowGroup {
            DogListView()
                .environmentObject(user)
                .environmentObject(dogData)
        }
    }
}
