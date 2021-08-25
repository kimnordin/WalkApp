//
//  DogListViewModel.swift
//  goDogUI
//
//  Created by Kim Nordin on 2021-05-04.
//

import Foundation

final class DogListViewModel: ObservableObject {
    var dogData: DogArray?
      
    func setup(_ dogData: DogArray) {
        self.dogData = dogData
    }
    
    func move(indices: IndexSet, newOffset: Int) {
        dogData?.list.move(fromOffsets: indices, toOffset: newOffset)
    }
    
    func delete(at index: IndexSet) {
        for i in index {
            dogData?.list.remove(at: i)
        }
    }
}
