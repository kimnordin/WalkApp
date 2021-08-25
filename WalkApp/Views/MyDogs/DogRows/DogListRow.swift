//
//  DogRow.swift
//  goDogPlus
//
//  Created by Kim Nordin on 2020-10-17.
//

import SwiftUI

struct DogListRow: View {
    @EnvironmentObject var user: User
    @ObservedObject var dog: Dog
    var body: some View {
        HStack(spacing: 10) {
            Image(uiImage: dog.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .padding()

            if !dog.walkArray.isEmpty {
                if let firstWalk = dog.walkArray.first {
                    if let time = firstWalk.time.timeToString() {
                        VStack {
                            Text("Latest Walk")
                                .font(.footnote)
                            Text(time)
                        }
                    }
                }
            }
            VStack(spacing: 3) {
                if dog.walkArray.first?.firstAction == true {
                    Text("1")
                        .frame(width: 65, height: 35)
                        .background(user.profile.firstColor)
                        .cornerRadius(15)
                }
                if dog.walkArray.first?.secondAction == true {
                    Text("2")
                        .frame(width: 65, height: 35)
                        .background(user.profile.secondColor)
                        .cornerRadius(15)
                }
            }
        }
    }
}

struct DogListRow_Previews: PreviewProvider {
    static var previews: some View {
        DogListRow(dog: testDogData[0])
    }
}
