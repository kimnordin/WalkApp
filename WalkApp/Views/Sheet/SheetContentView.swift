//
//  SheetContentView.swift
//  WalkApp
//
//  Created by Kim Nordin on 2024-06-09.
//

import SwiftUI

struct SheetContentView<Content: View>: View {
    @Binding var isPresented: Bool
    @Binding var item: AnyIdentifiable?
    @ViewBuilder var contentViews: Content
    @State private var sheetContentHeight: CGFloat = 0
    
    init(isPresented: Binding<Bool>, @ViewBuilder contentViews: @escaping () -> Content) {
        self._isPresented = isPresented
        self._item = .constant(nil)
        self.contentViews = contentViews()
    }
    
    init<Item: Identifiable>(item: Binding<Item?>, @ViewBuilder contentViews: @escaping () -> Content) {
        _isPresented = .constant(false)
        _item = Binding(
            get: { item.wrappedValue.map(AnyIdentifiable.init) },
            set: { newValue in item.wrappedValue = newValue?.value as? Item }
        )
        self.contentViews = {
            if item.wrappedValue != nil {
                return contentViews()
            } else {
                return EmptyView() as! Content
            }
        }()
    }
    
    var body: some View {
        VStack {
            if isPresented || item != nil {
                contentViews
            }
        }
        .padding()
        .fixedSize(horizontal: false, vertical: true)
        .modifier(HeightModifier(height: $sheetContentHeight))
        .dynamicSheet(sheetContentHeight)
    }
}

struct SheetContentView_Previews: PreviewProvider {
    static var previews: some View {
        SheetContentView(isPresented: .constant(true), contentViews: { Text("Hello!") })
    }
}
