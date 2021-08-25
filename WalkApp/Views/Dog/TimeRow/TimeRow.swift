//
//  WalkRow.swift
//  goDogPlus
//
//  Created by Kim Nordin on 2020-10-17.
//

import SwiftUI

struct TimeRow: View {
    @EnvironmentObject var user: User
    var walk: Walk
    var body: some View {
        HStack(spacing: 10) {
            Text(walk.time.timeToString())
                .font(.title)
                .opacity(0.7)
                .minimumScaleFactor(0.5)
                .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
            if walk.firstAction == true {
                Text("1")
                    .frame(width: 80, height: 22)
                    .background(user.profile.firstColor)
                    .cornerRadius(15)
            }
            if walk.secondAction == true {
                Text("2")
                    .frame(width: 80, height: 22)
                    .background(user.profile.secondColor)
                    .cornerRadius(15)
            }
        }
    }
}

struct TimeRow_Previews: PreviewProvider {
    static var previews: some View {
        TimeRow(walk: testWalkData[0])
    }
}
