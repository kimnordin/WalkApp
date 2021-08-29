//
//  Walk.swift
//  goDog
//
//  Created by Kim Nordin on 2020-05-10.
//  Copyright © 2020 kim. All rights reserved.
//

import Foundation

struct Walk: Codable {
    let id = UUID()
    var time: Date
    var firstAction: Bool?
    var secondAction: Bool?
}

#if DEBUG
let testWalkData = [
    Walk(time: Date(), firstAction: true, secondAction: true),
    Walk(time: Date(), firstAction: true, secondAction: true),
    Walk(time: Date(), firstAction: true, secondAction: true),
    Walk(time: Date(), firstAction: true, secondAction: true),
    Walk(time: Date(), firstAction: true, secondAction: true),
    Walk(time: Date(), firstAction: true, secondAction: true)
]
#endif
