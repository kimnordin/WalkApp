//
//  ProfileView.swift
//  WalkApp
//
//  Created by Kim Nordin on 2021-08-10.
//

import SwiftUI
import ReduxUI

struct SettingsView: View {
    @EnvironmentObject private var store: Store<AppState>
    @State private var selectedButton: ButtonType?
    
    @ViewBuilder private func ButtonTitleEditor(title: String, button: ButtonType) -> some View {
        TextField(title, text: Binding(
            get: { title },
            set: { SetButtonTitle(title: $0, button: button).dispatchFromMain() }
        ))
        .multilineTextAlignment(.trailing)
    }
    
    @ViewBuilder private func ButtonColorEditor(color: Color?, button: ButtonType) -> some View {
        Button {
            SelectSettingsButton(button: button).dispatchFromMain()
        } label: {
            Text("")
                .smallSelectionIndication(color: color)
        }
        .clipShape(Rectangle())
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Button Titles")) {
                        HStack {
                            Text("First Button Title")
                            ButtonTitleEditor(title: store.state.settingsState.firstTitle, button: .first)
                        }
                        HStack {
                            Text("Second Button Title")
                            ButtonTitleEditor(title: store.state.settingsState.secondTitle, button: .second)
                        }
                    }
                    Section(header: Text("Button Colors")) {
                        HStack {
                            Text("First Button Color")
                            Spacer()
                            ButtonColorEditor(color: store.state.settingsState.firstColor, button: .first)
                        }
                        HStack {
                            Text("Walk Button Color")
                            Spacer()
                            ButtonColorEditor(color: store.state.settingsState.walkColor, button: .walk)
                        }
                        HStack {
                            Text("Second Button Color")
                            Spacer()
                            ButtonColorEditor(color: store.state.settingsState.secondColor, button: .second)
                        }
                    }
                }
                Spacer()
                Button("Restore to Default") {
                    RestoreDefaultSettings().dispatchFromMain()
                }
                .foregroundColor(.dogOrange)
            }
            .navigationBarTitle("Settings")
            .padding(.bottom, 20)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        NavigateBack().dispatchFromMain()
                    } label: {
                        Image(systemName: "chevron.backward")
                    }
                }
            }
        }
        .onReceive(store.$state) {
            newState($0.settingsState)
        }
        .sheet(item: $selectedButton, onDismiss: {
            SelectSettingsButton(button: nil).dispatchFromMain()
        }) { _ in
            SheetContentView(item: $selectedButton) {
                ColorListView()
            }
        }
    }
}

extension SettingsView: StoreSubscriber {
    func newState(_ state: SettingsState) {
        selectedButton = state.selectedButton
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(store)
    }
}
