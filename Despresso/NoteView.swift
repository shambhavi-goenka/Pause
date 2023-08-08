//
//  RandomView.swift
//  Despresso
//
//  Created by Shambhavi Goenka on 1/7/23.
//
import SwiftUI

struct NoteView: View {
    
    @Environment(\.presentationMode) var presentationMode // Add this line
    
//    @Binding var selectedMood: Mood
    
    @State private var isNoteOpen = false
    @State private var noteText = ""
    @State private var selectedMood: Mood = .none
    
    enum Mood: String, CaseIterable {
        case rain, cloud, sun, none
        var promptQuestion: String {
            switch self {
            case .rain:
                return "What would make you feel better on a sad day?"
            case .cloud:
                return "How can you make an OK day better?"
            case .sun:
                return "What made you happy today?"
            case .none:
                return "Create a new note"
            }
        }
    }


    var body: some View {
        NavigationView {
            VStack {
                Text(selectedMood.promptQuestion)
                    .font(.title3)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()

                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .frame(height: .infinity)
                    .overlay(
                        TextEditor(text: $noteText)
                            .font(.body)
                            .padding()
                    )
                    .padding()

                Spacer()
            }
            .navigationBarItems(leading:
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.title2)
                        },
                        trailing:
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Done")
                                .font(.headline)
                        })
            
            .navigationBarTitle("Today's Note", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}




struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView()
    }
}

