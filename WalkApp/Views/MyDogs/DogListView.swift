//
//  DogsList.swift
//  goDogPlus
//
//  Created by Kim Nordin on 2020-10-17.
//

import SwiftUI

struct DogListView: View {
    @ObservedObject var viewModel: DogListViewModel
    @EnvironmentObject var user: User
    @EnvironmentObject var dogs: DogArray
    @State private var presentNew = false
    @State private var presentProfile = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<dogs.list.count, id: \.self) { dog in
                    ZStack(alignment: .leading) {
                        NavigationLink(destination: DogDetailView(dog: dogs.list[dog])) {
                        }
                        .opacity(0)
                        DogListRow(dog: dogs.list[dog])
                    }
                }
                .onMove(perform: move)
                .onDelete(perform: delete)
            }
            .background(NavigationLink(
                destination: NewDogView(viewModel: NewDogViewModel()),
                isActive: $presentNew) {
            })
            .background(NavigationLink(
                destination: ProfileView(),
                isActive: $presentProfile) {
            })
            .navigationBarTitle(Text("Dogs"))
            .navigationBarItems(leading:
                                    HStack {
                                        Button("Profile") {
                                            presentProfile = true
                                        }
                                    }
                                , trailing:
                                    HStack {
                                        Button("+") {
                                            presentNew = true
                                        }
                                    }
            )
            .onAppear {
                viewModel.setup(dogs)
            }
        }
    }
    private func move(at indexSet: IndexSet, to destination: Int) {
        dogs.list.move(fromOffsets: indexSet, toOffset: destination)
    }
    func delete(at indexSet: IndexSet) {
        dogs.list.remove(atOffsets: indexSet)
    }
}


struct DogsList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DogListView(viewModel: DogListViewModel())
        }
    }
}
