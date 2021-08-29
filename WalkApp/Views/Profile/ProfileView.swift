//
//  ProfileView.swift
//  goDogUI
//
//  Created by Kim Nordin on 2021-08-10.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var user: User
    @State var permProfile: Profile = Profile(walkColor: Color.orange, firstColor: Color.blue, secondColor: Color.pink)
    @State private var presentModal = false
    @State var selectedColor = SelectedColor.none
    
    let colors = [Color.red, Color.blue, Color.green, Color.orange, Color.pink, Color.yellow, Color.red, Color.white, Color.gray, Color.black]
    
    @ViewBuilder func ColorView(color: Color) -> some View {
        (color)
            .cornerRadius(10)
            .onTapGesture {
                switch selectedColor {
                case .walk:
                    permProfile.walkColor = color
                case .first:
                    permProfile.firstColor = color
                case .second:
                    permProfile.secondColor = color
                default: break
                }
            }
    }
    var body: some View {
        ZStack {
            VStack(spacing: 8) {
                Text("Edit Selection Items")
                    .font(.title)
                    .padding(.bottom)
                .padding(5)
                Text("Change the button color")
                    .font(.title3)
                    .padding(EdgeInsets(top: 12, leading: 0, bottom: 5, trailing: 0))
                HStack {
                    Button(action: {
                        presentModal = true
                        selectedColor = .first
                    }) {
                        Text("1")
                            .frame(width: 100, height: 50, alignment: .center)
                            .foregroundColor(.white)
                    }
                    .background(permProfile.firstColor)
                    .cornerRadius(30)
                    
                    Button(action: {
                        presentModal = true
                        selectedColor = .walk
                    }) {
                        Text("Walk")
                            .frame(width: 100, height: 50, alignment: .center)
                            .foregroundColor(.white)
                    }
                    .background(permProfile.walkColor)
                    .cornerRadius(30)
                    
                    Button(action: {
                        presentModal = true
                        selectedColor = .second
                    }) {
                        Text("2")
                            .frame(width: 100, height: 50, alignment: .center)
                            .foregroundColor(.white)
                    }
                    .background(permProfile.secondColor)
                    .cornerRadius(30)
                }
                Spacer()
            }
            .padding()
            if presentModal {
                ModalView() {
                    ScrollView {
                        VStack(spacing: 40) {
                            ForEach(colors, id: \.self) { color in
                                ColorView(color: color)
                                    .frame(minWidth: 20, maxWidth: .infinity, minHeight: 20, maxHeight: .infinity)
                                    .padding([.leading, .trailing], 20)
                            }
                        }
                    }
                } closeModal: {
                    presentModal = false
                }
            }
        }
        .onAppear() {
            permProfile = user.profile
        }
        .onDisappear() {
            user.profile = permProfile
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
