//
//  HeightModifier.swift
//  WalkApp
//
//  Created by Kim Nordin on 2024-06-09.
//

import SwiftUI

struct HeightModifier: ViewModifier {
    @Binding var height: CGFloat

    func body(content: Content) -> some View {
        content.background(
            GeometryReader { geometry -> Color in
                DispatchQueue.main.async {
                    height = geometry.size.height
                }
                return Color.clear
            }
        )
    }
}
