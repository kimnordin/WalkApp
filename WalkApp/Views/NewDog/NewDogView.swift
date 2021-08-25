//
//  NewDogView.swift
//  goDogPlus
//
//  Created by Kim Nordin on 2020-10-17.
//

import SwiftUI

struct NewDogView: View {
    @Environment(\.presentationMode) var presentation
    @State private var currentDate = Date()
    @State private var showDate = true
    @EnvironmentObject var dogs: DogArray
    @ObservedObject var viewModel = NewDogViewModel()
    @State var dogCreated: Bool = false
    var body: some View {
        ScrollView(showsIndicators: false) {
            if (viewModel.uiImage == nil) {
                Image(systemName: "camera.circle.fill")
                    .resizable()
                    .frame(width: 130, height: 130)
                    .onTapGesture {
                        viewModel.displayImagePicker()
                    }
            } else {
                Image(uiImage: viewModel.uiImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .cornerRadius(15)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .onTapGesture {
                        viewModel.displayActionSheet()
                    }
            }
            TextField("Enter the Dogs name", text: $viewModel.name)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 40, leading: 20, bottom: 20, trailing: 20))
            Toggle("Register Birth date", isOn: $showDate)
                .padding(EdgeInsets(top: 0, leading: 40, bottom: 10, trailing: 40))
            if showDate {
                DatePicker("Birth date ", selection: $currentDate, in: ...Date(), displayedComponents: .date)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .accentColor(Color.orange)
            }
        }
        .fixFlickering()
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: .default(alertItem.buttonTitle))
        })
        .sheet(isPresented: $viewModel.showImagePicker, onDismiss: {
            viewModel.dismissImagePicker()
        }, content: {
            ImagePicker(presenting: self.$viewModel.showImagePicker, uiImage: self.$viewModel.uiImage)
        })
        .actionSheet(isPresented: $viewModel.showAction) {
            viewModel.sheet
        }
        Group {
            Button(action: {
                createDog(name: viewModel.name, image: viewModel.uiImage)
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
        if viewModel.isDogValid(name: name, image: image) {
            dogs.addDog(dog: Dog(name: name, image: image!))
            dogCreated = true
        }
        else {
            dogCreated = false
        }
    }
}

struct NewDog_Previews: PreviewProvider {
    static var previews: some View {
        NewDogView(viewModel: NewDogViewModel())
            .environmentObject(DogArray())
    }
}
