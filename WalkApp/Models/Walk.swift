//
//  Walk.swift
//  WalkApp
//
//  Created by Kim Nordin on 2020-05-10.
//  Copyright © 2020 kim. All rights reserved.
//

import Foundation

struct Walk: Identifiable, Equatable {
    let id = UUID()
    var firstTime: Date
    var secondTime: Date {
        didSet {
            if firstTime > secondTime {
                firstTime = secondTime
            }
        }
    }
    var distance: Double
    var firstSelect: Bool = false
    var secondSelect: Bool = false
    
    init(firstTime: Date = Date(), secondTime: Date = Date(), distance: Double = 0.0, firstSelect: Bool = false, secondSelect: Bool = false) {
        self.firstTime = firstTime
        self.secondTime = secondTime
        self.distance = distance
        self.firstSelect = firstSelect
        self.secondSelect = secondSelect
    }
}
