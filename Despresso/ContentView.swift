//
//  ContentView.swift
//  Despresso
//
//  Created by Shambhavi Goenka on 1/7/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            HomeView()
                .navigationBarItems(leading:
                        
                      HStack(spacing: 0) {
                            Image("coffee")
                                .resizable()
                                .frame(width: 100, height: 100)
                            Text("Pause")
                                .font(.system(size: 44, weight: .bold))
                                .foregroundColor(.brown)
                            Spacer()
                    
                        }
                        .padding(.top, 10),
                        trailing: NavigationLink(destination: ProfileView()) {
                            Image(systemName: "person.circle")
                                .font(.system(size: 35))
                        }
                        .padding(.top, 10)
                                    
                )
        }

//        TabView {
//            HomeView().tabItem() {
//                Image(systemName: "house.fill")
//                Text("Home")
//            }
//
//            MeditateView().tabItem() {
//                Image(systemName: "leaf.fill")
//                Text("Meditate")
//            }
//
//            RandomView().tabItem() {
//                Image(systemName: "dice.fill")
//                Text("Random")
//            }
//
//            JournalView().tabItem() {
//                Image(systemName: "book.closed.fill")
//                Text("Journal")
//            }
//
//            ProfileView().tabItem() {
//                Image(systemName: "person.fill")
//                Text("Calls")
//            }
//        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
