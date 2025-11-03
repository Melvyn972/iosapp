//
//  TktApp.swift
//  Tkt
//
//  Created by THIERRY-BELLEFOND Melvyn on 03/11/2025.
//

import SwiftUI

@main
struct TktApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MenuView()
            }
        }
    }
}

struct MenuView: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Bienvenue !")
                .font(.largeTitle)
                .bold()
                .padding(.top, 50)
            
            NavigationLink(destination: ContentView()) {
                HStack {
                    Image(systemName: "list.bullet")
                        .font(.title2)
                    Text("Aller aux détails")
                        .font(.title2)
                        .bold()
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(15)
                .shadow(radius: 5)
            }
            .padding(.horizontal)
            
            NavigationLink(destination: ProfileView()) {
                HStack {
                    Image(systemName: "person.circle")
                        .font(.title2)
                    Text("Profile")
                        .font(.title2)
                        .bold()
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .cornerRadius(15)
                .shadow(radius: 5)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle("Accueil")
    }
}

