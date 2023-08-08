//
//  ProfileView.swift
//  Despresso
//
//  Created by Shambhavi Goenka on 1/7/23.
//

import SwiftUI
import UIKit

struct ProfileView: View {
    @State private var username: String = "username"
    @State private var isEditing: Bool = false // Track whether editing mode is enabled
    @State private var isEditingImage: Bool = false // Track whether the profile picture is being edited
    @State private var isSignedIn: Bool = true // Track whether the user is signed in
    @State private var selectedImage: UIImage? = nil
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 40)
            
            HStack {
                Spacer()
                if isSignedIn {
                    Button(action: {
                        // Toggle editing mode
                        isEditing.toggle()
                    }) {
                        Image(systemName: isEditing ? "pencil.circle.fill" : "pencil.circle")
                            .font(.system(size: 36))
                        
                    }
                    .padding(.trailing, 10)
                }
            }
            
            Button(action: {
                // Add action for editing profile picture
                if isEditing {
                    isEditingImage.toggle()
                }
            }) {
                if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage) // Display selected image
                            .resizable()
//                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                            .foregroundColor(.brown)
                    }
                else if isEditingImage {
                    Image(systemName: "pencil.circle.fill") // Pencil icon when editing profile picture
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                        .foregroundColor(.brown)
                } else {
                    Image(systemName: "person.circle") // Default person icon
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                        .foregroundColor(.brown)
                }
            }
            .sheet(isPresented: $isEditingImage) {
                if isEditingImage {
                    // Add image picker here for editing the profile picture
                    ImagePicker(selectedImage: $selectedImage, isPresented: $isEditingImage)
                }
            }
            
            Spacer()
                .frame(height: 30)
            
            if isSignedIn {
                if isEditing {
                    TextField("Username", text: $username)
                        .font(.system(size: 32, weight: .light))
                        .multilineTextAlignment(.center)
                } else {
                    Text(username)
                        .font(.system(size: 32, weight: .light))
                        .multilineTextAlignment(.center)
                }
            }
            
            Spacer()
                .frame(height: 320)
            
            Button(action: {
                if isSignedIn {
                    // Add action for signing out
                    selectedImage = nil // Clear the selected image
                    isSignedIn.toggle()
                    isEditing = false // Reset editing mode when signing out
                    username = "username"
                } else {
                    // Add action for signing in
                    isSignedIn.toggle()
                    isEditing = true // Start editing after signing in
                }
            }) {
                HStack {
                    Text(isSignedIn ? "Sign Out" : "Sign In")
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(.black)
                        .padding()
                        .padding(.trailing, -15)
                    
                    if isSignedIn {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(.black)
                            .padding()
                            .padding(.leading, -15)
                    } else {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(.black)
                            .padding()
                            .padding(.leading, -15)
                    }
                }
            }
            .background(Color.accentColor)
            .cornerRadius(15)
            
            Spacer()
                .frame(height: 50)
        }
    }
    
    struct ImagePicker: UIViewControllerRepresentable {
        @Binding var selectedImage: UIImage?
        @Binding var isPresented: Bool

        func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
            let picker = UIImagePickerController()
            picker.delegate = context.coordinator
            picker.sourceType = .photoLibrary
            return picker
        }

        func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}

        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }

        class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
            var parent: ImagePicker

            init(_ parent: ImagePicker) {
                self.parent = parent
            }

            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
                if let selectedImage = info[.originalImage] as? UIImage {
                    parent.selectedImage = selectedImage
                }
                parent.isPresented = false
            }

            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                parent.isPresented = false
            }
        }
    }


}



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
