//
//  Anyidentifiable.swift
//  WalkApp
//
//  Created by Kim Nordin on 2024-06-09.
//

import Foundation

struct AnyIdentifiable: Identifiable {
    let id: AnyHashable
    let value: Any

    init<T: Identifiable>(_ value: T) {
        self.id = AnyHashable(value.id)
        self.value = value
    }
}
