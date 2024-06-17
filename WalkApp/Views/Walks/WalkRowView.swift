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
    var walk: Walk
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(formattedDate())
                    .timeTitle(font: .footnote)
                    .opacity(0.7)
                    .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
                HStack {
                    Text(walk.firstTime.timeToString())
                        .timeTitle(font: .title)
                    Text(walk.secondTime.timeToString())
                        .timeTitle(font: .subheadline)
                }
            }
            Spacer()
            VStack(spacing: 3) {
                if walk.firstSelect {
                    Text(store.state.settingsState.firstTitle)
                        .selectionIndication(color: store.state.settingsState.firstColor)
                }
                if walk.secondSelect {
                    Text(store.state.settingsState.secondTitle)
                        .selectionIndication(color: store.state.settingsState.secondColor)
                }
            }
            .frame(width: 80)
            Text(walk.distance.formatDistance())
                .frame(width: 100)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
    }
    
    private func formattedDate() -> String {
        if walk.firstTime.dateToString() == walk.secondTime.dateToString() {
            let date = walk.firstTime.dateToString()
            return date
        } else {
            let firstDate = walk.firstTime.dateToString()
            let secondDate = walk.secondTime.dateToString()
            let combinedDate = "\(firstDate)  |  \(secondDate)"
            return combinedDate
        }
    }
}

struct WalkRowView_Previews: PreviewProvider {
    static var previews: some View {
        WalkRowView(walk: Walk(firstTime: Date()))
            .environmentObject(store)
    }
}
