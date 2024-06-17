//
//  Extensions.swift
//  WalkApp
//
//  Created by Kim Nordin on 2020-02-23.
//  Copyright © 2020 kim. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import ReduxUI

// MARK: - ReduxUI
extension Action {
    func dispatchFromMain() {
        DispatchQueue.main.async {
            store.dispatch(self)
        }
    }
}

// MARK: - Colors
extension Color {
    static let label = Color(UIColor.label)
    static let invertedLabel = Color(UIColor(dynamicProvider: { $0.userInterfaceStyle == .dark ? .black : .white }))
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue:  Double(b) / 255, opacity: Double(a) / 255)
    }
}

// MARK: - Types
extension Double {
    func truncate(places: Int) -> Double {
        return Double(floor(pow(10.0, Double(places)) * self) / pow(10.0, Double(places)))
    }
    
    func formatDistance(on threshold: Double = 1000) -> String {
        var stringDistance = ""
        
        if self >= threshold {
            if NSLocale.current.usesMetricSystem {
                stringDistance = String((self / 1000).truncate(places: 1))
                stringDistance += "km"
            } else {
                stringDistance = String((self / 1609.34).truncate(places: 1))
                stringDistance += "mi"
            }
        } else {
            if NSLocale.current.usesMetricSystem {
                stringDistance = String(format: "%.0f", self)
                stringDistance += "m"
            } else {
                stringDistance = String(format: "%.0f", self * 3.28084)
                stringDistance += "ft"
            }
        }
        return stringDistance
    }
}

extension Date {
    func timeToString(format: String = "HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

// MARK: - SwiftUI
extension View {
    func dynamicSheet(_ height: CGFloat) -> some View {
        if #available(iOS 16, *) {
           return self.presentationDetents([.height(height)])
        } else { return self }
    }
}

extension Button {
    func walkSelectionButton(selected: Bool, color: Color?) -> some View {
        background(selected ? color : nil)
            .cornerRadius(30)
            .overlay(selected ? nil : RoundedRectangle(cornerRadius: 30).stroke(color ?? .blue, lineWidth:2))
    }
}

extension Text {
    func walkActionButton(selected: Bool, selectedColor: Color? = .white, unselectedColor: Color? = .label, width: CGFloat = 90, height: CGFloat = 60) -> some View {
        bold()
            .frame(width: width, height: height)
            .foregroundColor(selected ? selectedColor : unselectedColor)
            .lineLimit(1)
    }
    
    func selectionIndication(color: Color?) -> some View {
        frame(width: 80, height: 22)
            .foregroundColor(.white)
            .background(color)
            .cornerRadius(15)
    }
    
    func smallSelectionIndication(color: Color?) -> some View {
        frame(width: 65, height: 22)
            .foregroundColor(.white)
            .background(color)
            .cornerRadius(15)
    }
}
