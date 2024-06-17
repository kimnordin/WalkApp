//
//  ColorListView.swift
//  WalkApp
//
//  Created by Kim Nordin on 2024-06-11.
//

import SwiftUI
import ReduxUI

struct ColorListView: View {
    @EnvironmentObject private var store: Store<AppState>
    @State private var selectedButton: ButtonType?
    
    @ViewBuilder private func ColorView(color: Color) -> some View {
        if let selectedButton = selectedButton {
            (color)
                .cornerRadius(10)
                .onTapGesture {
                    SetButtonColor(color: color, button: selectedButton).dispatchFromMain()
                }
        }
    }
    
    let columns = Array(repeating: GridItem(.flexible(minimum: 20, maximum: 20)), count: 12)
    
    var body: some View {
        VStack(spacing: 20) {
            LazyVGrid(columns: columns, spacing: 20, pinnedViews: .sectionHeaders) {
                ForEach(0..<fetchColorDataArray().count, id: \.self) { index in
                    let color = returnColor(from: index)
                    ColorView(color: color)
                        .frame(minWidth: 20, maxWidth: .infinity, minHeight: 20, maxHeight: .infinity)
                }
            }
            if let selectedButton = selectedButton {
                Circle()
                    .strokeBorder(Color.label, lineWidth: 4)
                    .frame(width: 65, height: 65)
                    .background(Circle().foregroundColor(buttonColor(selectedButton)))
                    .padding()
            }
        }
        .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
        .onReceive(store.$state) {
            newState($0.settingsState)
        }
    }
    
    private func buttonColor(_ button: ButtonType) -> Color {
        switch button {
        case .walk:
            return store.state.settingsState.walkColor
        case .first:
            return store.state.settingsState.firstColor
        case .second:
            return store.state.settingsState.secondColor
        default: return .white
        }
    }
    
    private func returnColor(from index: Int) -> Color {
        let colors = fetchColorDataArray()
        let colorHex = colors[index]
        return Color(hex: colorHex)
    }
    
    private func fetchColorDataArray() -> [String] {
        if let path = Bundle.main.path(forResource: "Colors", ofType: "plist") {
            if let color = NSArray(contentsOfFile: path) {
                return color as! [String]
            }
        }
        return []
    }
}

extension ColorListView: StoreSubscriber {
    func newState(_ state: SettingsState) {
        selectedButton = state.selectedButton
    }
}

struct ColorListView_Previews: PreviewProvider {
    static var previews: some View {
        ColorListView()
            .environmentObject(store)
    }
}

