//
//  EditWalkView.swift
//  WalkApp
//
//  Created by Kim Nordin on 2021-08-22.
//

import SwiftUI
import ReduxUI

struct EditWalkView: View {
    @EnvironmentObject private var store: Store<AppState>
    @State private var walk: Walk?
    
    var body: some View {
        VStack {
            Text("Edit your Walk")
                .font(.title)
                .padding([.bottom], 20)
            if let walk = walk {
                DatePicker("First Date", selection: Binding(
                    get: { walk.firstTime },
                    set: { SelectedWalkUpdateFirstTime(date: $0).dispatchFromMain() }
                ), in: ...walk.secondTime, displayedComponents: [.date, .hourAndMinute])
                    .padding([.bottom, .leading, .trailing], 20)
                    .datePickerStyle(DefaultDatePickerStyle())
                    .accentColor(.dogOrange)
                DatePicker("Second date ", selection: Binding(
                    get: { walk.secondTime },
                    set: { SelectedWalkUpdateSecondTime(date: $0).dispatchFromMain() }
                ), in: ...Date(), displayedComponents: [.date, .hourAndMinute])
                    .padding([.bottom, .leading, .trailing], 20)
                    .datePickerStyle(DefaultDatePickerStyle())
                    .accentColor(.dogOrange)
            }
            HStack(spacing: 30) {
                EditWalkFirstButtonView()
                EditWalkSecondButtonView()
            }
        }
        .frame(maxWidth: .infinity)
        .onReceive(store.$state) {
            newState($0.selectedWalkState)
        }
    }
}

extension EditWalkView: StoreSubscriber {
    func newState(_ state: SelectedWalkState) {
        walk = state.selectedWalk
    }
}

struct EditWalkView_Previews: PreviewProvider {
    static var previews: some View {
        EditWalkView()
            .environmentObject(store)
    }
}
