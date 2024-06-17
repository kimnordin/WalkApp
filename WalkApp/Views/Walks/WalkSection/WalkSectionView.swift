//
//  WalkSectionView.swift
//  WalkApp
//
//  Created by Kim Nordin on 2021-08-22.
//

import SwiftUI
import ReduxUI

struct WalkSectionView: View {
    @EnvironmentObject private var store: Store<AppState>
    @State private var walk: Walk?

    var body: some View {
        VStack(spacing: 10) {
            if let walk = walk {
                HStack(spacing: 30) {
                    Text(walk.distance.formatDistance())
                        .font(.title)
                    Text(walk.firstTime.timeToString())
                        .font(.title)
                }
            }
            HStack(spacing: 8) {
                if let _ = walk {
                    FirstButtonView()
                }
                WalkButtonView()
                if let _ = walk {
                    SecondButtonView()
                }
            }
        }
        .padding(.top, 10)
        .onReceive(store.$state) {
            newState($0.pendingWalkState)
        }
    }
}

extension WalkSectionView: StoreSubscriber {
    func newState(_ state: PendingWalkState) {
        walk = state.pendingWalk
    }
}

struct WalkSectionView_Previews: PreviewProvider {
    static var previews: some View {
        WalkSectionView()
            .environmentObject(store)
    }
}
