//
//  NewDogViewModel.swift
//  goDogPlus
//
//  Created by Kim Nordin on 2021-05-03.
//

import SwiftUI

final class NewDogViewModel: ObservableObject {
    @Published var alertItem: AlertItem?
    @Published var name: String = ""
    @Published var uiImage: UIImage? = nil
    @Published var showAction: Bool = false
    @Published var showImagePicker: Bool = false
    var sheet: ActionSheet {
        ActionSheet(
            title: Text("Action"),
            message: Text("Update Image"),
            buttons: [
                .default(Text("Change"), action: {
                    self.dismissActionSheet()
                    self.displayImagePicker()
                }),
                .cancel(Text("Close"), action: {
                    self.dismissActionSheet()
                }),
                .destructive(Text("Remove"), action: {
                    self.dismissActionSheet()
                    self.uiImage = nil
                })
            ])
    }
    
    func displayActionSheet() {
        showAction = true
    }
    
    func dismissActionSheet() {
        showAction = false
    }
    
    func displayImagePicker() {
        showImagePicker = true
    }
    
    func dismissImagePicker() {
        showImagePicker = false
    }
    
    func isDogValid(name: String, image: UIImage?) -> Bool {
        if name != "" && image != nil {
            return true
        }
        else if name == "" && image != nil  {
            alertItem = AlertContext.NewDog.noName
        }
        else if name != "" && image == nil {
            alertItem = AlertContext.NewDog.noImage
        }
        else {
            alertItem = AlertContext.NewDog.noNameNoImage
        }
        return false
    }
}
