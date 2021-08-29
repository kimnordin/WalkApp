//
//  NewDogView.swift
//  goDogPlus
//
//  Created by Kim Nordin on 2020-10-17.
//

import SwiftUI

struct NewDogView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var dogs: DogArray
    @State var alertItem: AlertItem?
    @State var dogCreated: Bool = false
    @State var name: String = ""
    @State var uiImage: UIImage? = nil
    @State var showAction: Bool = false
    @State var showImagePicker: Bool = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            if (uiImage == nil) {
                Image(systemName: "camera.circle.fill")
                    .resizable()
                    .frame(width: 130, height: 130)
                    .onTapGesture {
                        displayImagePicker()
                    }
            } else {
                Image(uiImage: uiImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .cornerRadius(15)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .onTapGesture {
                        displayActionSheet()
                    }
            }
            TextField("Enter the Dogs name", text: $name)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 40, leading: 20, bottom: 20, trailing: 20))
        }
        .fixFlickering()
        .alert(item: $alertItem, content: { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: .default(alertItem.buttonTitle))
        })
        .sheet(isPresented: $showImagePicker, onDismiss: {
            dismissImagePicker()
        }, content: {
            ImagePicker(presenting: $showImagePicker, uiImage: $uiImage)
        })
        .actionSheet(isPresented: $showAction) {
            sheet
        }
        Group {
            Button(action: {
                createDog(name: name, image: uiImage)
                if dogCreated {
                    self.presentation.wrappedValue.dismiss()
                }
            }, label: {
                Text("Add dog")
                    .frame(width: 120, height: 60)
                    .foregroundColor(.white)
            })
            .padding(.horizontal, 8).lineLimit(1).minimumScaleFactor(0.4)
            .background(Color.orange)
            .cornerRadius(30)
        }
    }
    private func createDog(name: String, image: UIImage? = nil) {
        if isDogValid(name: name, image: image) {
            dogs.addDog(dog: Dog(name: name, image: image!))
            dogCreated = true
        }
        else {
            dogCreated = false
        }
    }
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

struct NewDog_Previews: PreviewProvider {
    static var previews: some View {
        NewDogView()
    }
}
