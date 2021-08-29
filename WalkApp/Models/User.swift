//
//  Profile.swift
//  goDogUI
//
//  Created by Kim Nordin on 2021-08-21.
//

import Foundation
import SwiftUI

class User: ObservableObject {
    @Published var profile: Profile {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(profile) {
                UserDefaults.standard.set(encoded, forKey: "Profile")
            }
        }
    }
    init() {
        if let profile = UserDefaults.standard.data(forKey: "Profile") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode(Profile.self, from: profile) {
                self.profile = decoded
                return
            }
        }
        self.profile = Profile()
    }
}

struct Profile: Identifiable, Codable {
    enum CodingKeys: CodingKey {
        case walkColor, firstColor, secondColor
    }
    
    let id = UUID()
    var walkColor: Color? = Color.orange
    var firstColor: Color? = Color.blue
    var secondColor: Color? = Color.pink
    
    init() {}
    
    init(walkColor: Color? = Color.orange, firstColor: Color? = Color.blue, secondColor: Color? = Color.pink) {
        self.walkColor = walkColor
        self.firstColor = firstColor
        self.secondColor = secondColor
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let walkData = try container.decode(Data.self, forKey: .walkColor)
        let firstData = try container.decode(Data.self, forKey: .firstColor)
        let secondData = try container.decode(Data.self, forKey: .secondColor)
        walkColor = dataToColor(walkData)
        firstColor = dataToColor(firstData)
        secondColor = dataToColor(secondData)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        let walkUiColor = walkColor?.toUiColor() ?? .orange
        let firstUiColor = firstColor?.toUiColor() ?? .blue
        let secondUiColor = secondColor?.toUiColor() ?? .systemPink
        let walkData = toData(walkUiColor)
        let firstData = toData(firstUiColor)
        let secondData = toData(secondUiColor)
        
        try container.encodeIfPresent(walkData, forKey: .walkColor)
        try container.encodeIfPresent(firstData, forKey: .firstColor)
        try container.encodeIfPresent(secondData, forKey: .secondColor)
    }
    
    func dataToColor(_ data: Data) -> Color? {
        do {
            if let dataColor = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor {
                return Color(dataColor)
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    func toData(_ uiColor: UIColor) -> Data? {
        do {
            let colorData = try NSKeyedArchiver.archivedData(withRootObject: uiColor, requiringSecureCoding: false)
            return colorData
        } catch {
            print(error)
        }
        return nil
    }
}

enum SelectedColor {
    case walk
    case first
    case second
    case none
}

#if DEBUG
let testUserData = User()
let testProfileData = [
    Profile(walkColor: Color.orange, firstColor: Color.blue, secondColor: Color.pink)
]
#endif
