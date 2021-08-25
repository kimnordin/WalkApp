//
//  Extensions.swift
//  goDog
//
//  Created by Kim Nordin on 2020-02-23.
//  Copyright © 2020 kim. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import CoreMotion

//Types
extension Array where Element == Walk {
    // Sort the dates ascended by the first date
    func sortWalksByDates() -> [Walk] {
        let array = self.sorted(by: { $0.time.compare($1.time) == .orderedDescending })
        return array
    }
}

extension Int {
    func times(_ f: () -> ()) {
        if self > 0 {
            for _ in 0..<self {
                f()
            }
        }
    }
}

extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
    
    func toDateAndTime() -> Date? {
        let dateTimeFormatter = DateFormatter()
        dateTimeFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        if let dateTime = dateTimeFormatter.date(from: self) {
            return dateTime
        }
        else {
            print("Couldn't format toDateAndTime")
            return nil
        }
    }
}

extension Double {
    func truncate(places : Int)-> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
    
    func formattedDistanceForMeters() -> String {
        var stringDistance = ""
        if self >= 100 {
            if NSLocale.current.usesMetricSystem
            {
                stringDistance = String((self / 1000).truncate(places: 3))
                stringDistance += "km"
            }
            else
            {
                stringDistance = String((self / 1609.34).truncate(places: 3))
                stringDistance += "mi"
            }
        }
        else {
            stringDistance = String(self)
            if NSLocale.current.usesMetricSystem
            {
                stringDistance = String(self.truncate(places: 1))
                stringDistance += "m"
            }
            else {
                stringDistance = String(self.truncate(places: 1))
                stringDistance += "ft"
            }
        }
        return stringDistance
    }
}

extension Data {
    func toString() -> String? {
        return String(data: self, encoding: .utf8)
    }
    func toImage() -> UIImage? {
        guard let uiImage = UIImage(data: self) else { return nil }
        return uiImage
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

//UIViews
extension Image {
    func toString(uiImage: UIImage) -> String? {
        let data: Data? = uiImage.jpegData(compressionQuality: 0.1)
        return data?.base64EncodedString(options: .lineLength64Characters)
    }
    func toData(uiImage: UIImage) -> Data? {
        guard let data: Data = uiImage.jpegData(compressionQuality: 1) else { return nil }
        return data
    }
}

extension UIImage {
    func toString() -> String? {
        let data: Data? = self.jpegData(compressionQuality: 0.1)
        return data?.base64EncodedString(options: .lineLength64Characters)
    }
    func toData() -> Data? {
        guard let data: Data = self.jpegData(compressionQuality: 1) else { return nil }
        return data
    }
}

extension Color {
    func toUiColor() -> UIColor {
        return UIColor(self)
    }
}

extension UIColor {
    func toColor() -> Color {
        return Color(self)
    }
    convenience init(hexString:String) {
        let scanner = Scanner(string: hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0

        self.init(red:red, green:green, blue:blue, alpha:1)
    }
}
extension UIViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func openGallery(vc: UIViewController) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = vc
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            vc.present(imagePicker, animated: true, completion: nil)
        }
        else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access the gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            vc.present(alert, animated: true, completion: nil)
        }
    }
}

extension ScrollView {
    // Fixes ScrollView flickering behind navigation-bar glitch
    public func fixFlickering() -> some View {
        return self.fixFlickering { (scrollView) in
            return scrollView
        }
    }
    public func fixFlickering<T: View>(@ViewBuilder configurator: @escaping (ScrollView<AnyView>) -> T) -> some View {
        GeometryReader { geometryWithSafeArea in
            GeometryReader { geometry in
                configurator(
                    ScrollView<AnyView>(self.axes, showsIndicators: self.showsIndicators) {
                        AnyView(
                            VStack {
                                self.content
                            }
                            .padding(.top, geometryWithSafeArea.safeAreaInsets.top)
                            .padding(.bottom, geometryWithSafeArea.safeAreaInsets.bottom)
                            .padding(.leading, geometryWithSafeArea.safeAreaInsets.leading)
                            .padding(.trailing, geometryWithSafeArea.safeAreaInsets.trailing)
                        )
                    }
                )
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
