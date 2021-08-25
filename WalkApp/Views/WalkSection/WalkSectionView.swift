//
//  WalkSectionView.swift
//  goDogUI
//
//  Created by Kim Nordin on 2021-08-22.
//

import SwiftUI
import CoreMotion

struct WalkSectionView: View {
    @EnvironmentObject var user: User
    @ObservedObject var dog: Dog
    @State private var startTime: Date = Date()
    var newWalk = true // Only display the 2 other buttons
    private let pedometer = CMPedometer()
    var walkIndex: Int = -1
    var body: some View {
        VStack {
            HStack(spacing: newWalk ? 8 : 30) {
                Button(action: {
                    dog.firstSelect.toggle()
                }, label: {
                    Text("1")
                        .frame(width: 90, height: 60)
                        .foregroundColor(.white)
                })
                .background(user.profile.firstColor)
                .opacity(dog.firstSelect ? 1.0 : 0.6)
                .cornerRadius(30)
                Button(action: {
                    dog.walk(time: Date(), firstSelect: dog.firstSelect, secondSelect: dog.secondSelect)
                    dog.firstSelect = false
                    dog.secondSelect = false
                    dog.sortWalks()
                }, label: {
                    Text("Walk")
                        .frame(width: 120, height: 60)
                        .foregroundColor(.white)
                })
                .background(user.profile.walkColor)
                .cornerRadius(30)
                Button(action: {
                    dog.secondSelect.toggle()
                }, label: {
                    Text("2")
                        .frame(width: 90, height: 60)
                        .foregroundColor(.white)
                        .lineLimit(1)
                })
                .background(user.profile.secondColor)
                .opacity(dog.secondSelect ? 1.0 : 0.6)
                .cornerRadius(30)
            }
        }
    }
}

struct WalkSectionView_Previews: PreviewProvider {
    static var previews: some View {
        WalkSectionView(dog: testDogData[0])
    }
}
