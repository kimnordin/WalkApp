//
//  DogDetail.swift
//  goDogPlus
//
//  Created by Kim Nordin on 2020-10-17.
//

import SwiftUI
import CoreMotion

struct DogDetailView: View {
    @ObservedObject var dog: Dog
    private let pedometer = CMPedometer()
    var body: some View {
        // Dog Section
        ZStack {
            VStack {
                HStack {
                    Image(uiImage: dog.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 110, height: 110)
                        .clipShape(Circle())
                    VStack(alignment: .leading) {
                        Text(dog.name)
                            .font(.title)
                    }
                    .padding(.leading, 8)
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 8, trailing: 10))
                List {
                    ForEach(0..<dog.walkArray.count, id: \.self) { walk in
                        ZStack(alignment: .leading) {
                            
                            TimeRow(walk: dog.walkArray[walk])
                        }
                    }
                }
                Group {
                    WalkSectionView(dog: dog)
                }
            }
        }
    }
}

struct DogDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DogDetailView(dog: testDogData[0])
    }
}
