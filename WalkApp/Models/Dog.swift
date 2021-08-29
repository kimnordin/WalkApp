//
//  Dog.swift
//  goDogPlus
//
//  Created by Kim Nordin on 2020-10-17.
//

import Foundation
import UIKit

class DogArray: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case list
    }
    @Published var list: [Dog] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(list) {
                UserDefaults.standard.set(encoded, forKey: "Dogs")
            }
        }
    }
    init() {
        if let dog = UserDefaults.standard.data(forKey: "Dogs") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Dog].self, from: dog) {
                self.list = decoded
                return
            }
        }
        self.list = []
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        list = try container.decode([Dog].self, forKey: .list)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(list, forKey: .list)
    }
    
    var count : Int {
        return list.count
    }
    
    func addDog(dog: Dog) {
        list.append(dog)
    }
    
    func clearDogs() {
        list.removeAll()
    }
    
    func deleteDog(index: Int){
        list.remove(at: index)
    }

    func entry(index: Int) -> Dog? {
        if index >= 0 && index <= list.count {
            return list[index]
        }
        return nil
    }
}

class Dog: ObservableObject, Identifiable, Codable {
    enum CodingKeys: CodingKey {
        case name, image, startDisplayDate, walkArray, firstSelect, secondSelect
    }
    
    let id = UUID()
    var name: String
    var image: UIImage
    var startDisplayDate: Date? = Date()
    @Published var walkArray = [Walk]()
    @Published var firstSelect: Bool = false
    @Published var secondSelect: Bool = false
    
    init(name: String, image: UIImage, startDisplayDate: Date? = Date(), walkArray: [Walk] = [Walk](), firstSelect: Bool = false, secondSelect: Bool = false) {
        self.name = name
        self.image = image
        self.startDisplayDate = startDisplayDate
        self.walkArray = walkArray
        self.firstSelect = firstSelect
        self.secondSelect = secondSelect
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        let dataImage = try container.decode(Data.self, forKey: .image)
        if let uiImage = dataImage.toImage() {
            image = uiImage
        }
        else {
            image = UIImage(systemName: "questionmark.circle.fill")!
        }
        startDisplayDate = try container.decode(Date.self, forKey: .startDisplayDate)
        walkArray = try container.decode([Walk].self, forKey: .walkArray)
        firstSelect = try container.decode(Bool.self, forKey: .firstSelect)
        secondSelect = try container.decode(Bool.self, forKey: .secondSelect)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(image.toData(), forKey: .image)
        try container.encode(startDisplayDate, forKey: .startDisplayDate)
        try container.encode(walkArray, forKey: .walkArray)
        try container.encode(firstSelect, forKey: .firstSelect)
        try container.encode(secondSelect, forKey: .secondSelect)
    }
    
    func walk(time: Date, firstSelect: Bool, secondSelect: Bool) {
        let walk = Walk(time: time, firstAction: firstSelect, secondAction: secondSelect)
        walkArray.append(walk)
        sortWalks()
    }
    
    func sortWalks() {
        walkArray = walkArray.sortWalksByDates()
    }
}

#if DEBUG
let testDogData = [
    Dog(name: "Balto", image: UIImage(named: "balto")!, walkArray: testWalkData, firstSelect: true, secondSelect: false),
    Dog(name: "Pelle", image: UIImage(named: "pelle")!, walkArray: testWalkData, firstSelect: false, secondSelect: false),
    Dog(name: "Armani", image: UIImage(named: "armani")!, walkArray: testWalkData, firstSelect: true, secondSelect: true),
    Dog(name: "Moss", image: UIImage(named: "moss")!, walkArray: testWalkData, firstSelect: false, secondSelect: true)
]
#endif
