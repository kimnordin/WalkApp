//
//  Alerts.swift
//  TicTacToe
//
//  Created by Kim Nordin on 2021-05-03.
//

import Foundation
import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    
    struct NewDog {
        static let noName = AlertItem(title: Text("Missing Credentials"),
                                      message: Text("Dog needs a Name"),
                                      buttonTitle: Text("Okay"))
        static let noImage = AlertItem(title: Text("Missing Credentials"),
                                       message: Text("Dog needs an Image"),
                                       buttonTitle: Text("Okay"))
        static let noNameNoImage = AlertItem(title: Text("Missing Credentials"),
                                             message: Text("Dog needs an Image and a Name"),
                                             buttonTitle: Text("Okay"))
    }
    static let draw = AlertItem(title: Text("Draw!"),
                                message: Text("What a battle of wits we have here..."),
                                buttonTitle: Text("Try Again!"))
}
