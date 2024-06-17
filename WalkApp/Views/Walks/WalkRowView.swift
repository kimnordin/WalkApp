//
//  WalkRowView.swift
//  WalkApp
//
//  Created by Kim Nordin on 2020-10-17.
//

import SwiftUI
import ReduxUI

struct WalkRowView: View {
    @EnvironmentObject private var store: Store<AppState>
    @State var walk: Walk?
    
    @ViewBuilder private func WalkTimeView(_ walk: Walk) -> some View {
        VStack(spacing: 4) {
            let first = walk.firstTime.timeToString()
            let second = walk.secondTime.timeToString()
            Text(first + " | " + second)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
        .padding(.trailing, 10)
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder private func WalkSelectionView(_ walk: Walk) -> some View {
        VStack(spacing: 3) {
            if walk.firstSelect {
                Text(store.state.settingsState.firstTitle)
                    .smallSelectionIndication(color: store.state.settingsState.firstColor)
            }
            if walk.secondSelect {
                Text(store.state.settingsState.secondTitle)
                    .smallSelectionIndication(color: store.state.settingsState.secondColor)
            }
        }
        .padding(5)
    }
    
    var body: some View {
        HStack(alignment: .center) {
            if let walk = walk {
                WalkTimeView(walk)
                Spacer()
                WalkSelectionView(walk)
            }
        }
    }
}

struct WalkRowView_Previews: PreviewProvider {
    static var previews: some View {
        WalkRowView()
            .environmentObject(store)
    }
}
