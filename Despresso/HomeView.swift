//
//  HomeView.swift
//  Despresso
//
//  Created by Shambhavi Goenka on 1/7/23.
//

import SwiftUI
import SwiftUICharts
import Charts

struct MoodEntry: Codable {
    let mood: HomeView.Mood
    let date: Date
}


struct HomeView: View {
    
//    @Environment(\.presentationMode) var presentationMode // Add this line
    
    
    @State private var selectedMood: Mood = .none
    @State private var isNoteOpen = false
    @State private var noteText = ""
    @State private var moodEntries: [MoodEntry] = UserDefaults.standard.decode([MoodEntry].self, forKey: "MoodEntries") ?? []

    enum Mood: String, Codable {
        case rain, cloud, sun, none

        var backgroundImage: Image {
            switch self {
            case .rain:
                return Image("rain")
            case .cloud:
                return Image("cloud")
            case .sun:
                return Image("sun")
            case .none:
                return Image("default")
            }
        }

        var symbolName: String {
            switch self {
            case .rain:
                return "cloud.bolt.rain"
            case .cloud:
                return "cloud.sun"
            case .sun:
                return "sun.max"
            case .none:
                return ""
            }
        }
        
        var moodValue: Int {
            switch self {
            case .rain:
                return 0
            case .cloud:
                return 1
            case .sun:
                return 2
            case .none:
                return 1
            }
        }
        
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
    
    private func saveMoodEntry() {
            let moodEntry = MoodEntry(mood: selectedMood, date: Date())
            moodEntries.append(moodEntry)

            // Keep only the last 3 entries (today, yesterday, and day before yesterday)
            if moodEntries.count > 3 {
                moodEntries.removeFirst(moodEntries.count - 3)
            }

            UserDefaults.standard.encode(moodEntries, forKey: "MoodEntries")
        }

    var body: some View {
        Grid{
            GridRow{
                Spacer()
                    .frame(height: 40)
            }
            GridRow {
                VStack {
                    Text("How's the weather?")
                        .padding(4)
                        .font(.system(size: 32, weight: .light))
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(10)
                    
                    Spacer()
                        .frame(height: 95)

                    HStack(spacing: 30) {
                        MoodButton(mood: .rain, selectedMood: $selectedMood)
                        MoodButton(mood: .cloud, selectedMood: $selectedMood)
                        MoodButton(mood: .sun, selectedMood: $selectedMood)
                    }
                }
                .frame(width: 350, height: 250)
                .background(selectedMood.backgroundImage
                                .resizable()
                                .scaledToFill()
                                .edgesIgnoringSafeArea(.all)
                                .brightness(-0.1))
                .cornerRadius(15)
            }
            GridRow{
                Spacer()
                    .frame(height: 15)
            }
            
            
            Button(action: {
                isNoteOpen = true
            }){
                
                GridRow {
                    let note = selectedMood.promptQuestion + "\n\n\n\n"
                    
                    VStack (alignment: .leading) {
                        
                        ZStack{
                            
                            Rectangle()
                                .fill(.brown)
                                .frame(height: 50)
                            
                            Text("Notes")
                                .font(.system(size: 22, weight: .light))
                                .foregroundColor(.white)

                        }
                        
                        
                        Text(note)
                            .padding()
                            .padding(.bottom, -10)
                            .padding(.top, -5)
                            .font(.system(size: 20, weight: .light))
                            .lineSpacing(2.5)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                    .frame(width: 350, height: 200)
                    .background(
                        GeometryReader { geometry in
                            StripedRectangle(stripeColor: Color.black, stripeSpacing: 25, geometry: geometry)
                        })
                    .cornerRadius(15)
                }
                
            }
            .fullScreenCover(isPresented: $isNoteOpen) {
                NoteView()
//                NoteView(selectedMood: $selectedMood)
            }
            
            
                
            GridRow{
                Spacer()
                    .frame(height: 15)
            }
            GridRow{
                
                VStack {
                    ChartsExample(selectedMood: $selectedMood)
                }
            }
            GridRow {
                Spacer()
            }
        }
        .background(Color("BackgroundColor"))

    }
    
    struct ChartsExample: View {
        @Binding var selectedMood: Mood
        
        var body: some View {
            VStack {
                VStack{
                    Spacer()
                                        
                    Text("Mood graph")
                        .font(.system(size: 24, weight: .light))
                    
                    Spacer()
                    
                    Chart {
                        AreaMark(
                            x: .value("Mood", "Day before"),
                            y: .value("Value", 0)
                        )
                        AreaMark(
                            x: .value("Mood", "Yesterday"),
                            y: .value("Value", 1)
                        )
                        AreaMark(
                            x: .value("Mood", "Today"),
                            y: .value("Value",selectedMood.moodValue)
                        )
                        
                    }
                    .frame(width: 300, height: 150)
                    .chartYAxis {
                        AxisMarks(values: [0, 1, 2]) {
                                 AxisGridLine()
                             }
                    }

                
                    
                    Spacer()
                }
                .frame(width: 350, height: 230)
                .background(Color(.white))
                .cornerRadius(15)
            }
        }
    }
    
//    struct NoteView: View {
//        @Binding var selectedMood: Mood
//
//        @State private var fullText: String = "This is some editable text..."
//
//        var body: some View{
//
//
//            NavigationView {
//                VStack {
//
//                    Text(selectedMood.promptQuestion)
//                        .font(.title3)
//                        .foregroundColor(.gray)
//                        .multilineTextAlignment(.center)
//                        .padding()
//
//                    RoundedRectangle(cornerRadius: 10)
//                        .foregroundColor(.white)
//                        .frame(height: .infinity)
//                        .overlay(
//                            TextEditor(text: $fullText)
//                                .font(.body)
//                                .padding()
//                        )
//                        .padding()
//
//                    Spacer()
//                }
//                .navigationBarItems(leading:
//                        Button(action: {
////                                presentationMode.wrappedValue.dismiss()
//                        }) {
//                            Image(systemName: "chevron.left")
//                                .font(.title2)
//                },
//
//
//                trailing:
//                        Button(action: {
////                                presentationMode.wrappedValue.dismiss()
//                        }) {
//                            Text("Done")
//                                .font(.headline)
//                        })
//
//                .navigationBarTitle("Today's Note", displayMode: .inline)
//            }
//
//        }
//    }
    
    struct StripedRectangle: View {
        var stripeColor: Color
        var stripeSpacing: CGFloat
        var geometry: GeometryProxy
        
        var body: some View {
            ZStack(alignment: .top) {
                
                Rectangle()
                    .fill(Color.white)
                
                
                ForEach(0..<stripeCount, id: \.self) { index in
                    stripe(at: index)
                }
            }
        }
        
        private var stripeCount: Int {
            Int(geometry.size.height / stripeSpacing)
        }
        
        private func stripe(at index: Int) -> some View {
            let stripeHeight = stripeSpacing
            let yPosition = CGFloat(index) * stripeHeight
            
            return Rectangle()
                .fill(stripeColor)
                .frame(height: 1)
                .offset(y: yPosition)
        }
    }

    struct MoodButton: View {
        let mood: Mood
        @Binding var selectedMood: Mood

        var body: some View {
            Button(action: {
                selectedMood = mood
            }) {
                Image(systemName: mood == selectedMood ? "\(mood.symbolName).fill" : "\(mood.symbolName)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
            .foregroundColor(Color("AccentColor"))
//            .foregroundColor(mood == selectedMood ? .white : .black)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


extension UserDefaults {
    func encode<T: Encodable>(_ value: T, forKey key: String) {
        do {
            let data = try JSONEncoder().encode(value)
            self.set(data, forKey: key)
        } catch {
            print("Error encoding value for key \(key): \(error)")
        }
    }

    func decode<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = self.data(forKey: key) else { return nil }
        do {
            let value = try JSONDecoder().decode(type, from: data)
            return value
        } catch {
            print("Error decoding value for key \(key): \(error)")
            return nil
        }
    }
}


