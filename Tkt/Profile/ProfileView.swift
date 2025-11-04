//
//  ProfileView.swift
//  Tkt
//
//  Created by THIERRY-BELLEFOND Melvyn on 03/11/2025.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @State var profileviewmodel = ProfileViewModel()
    @State private var modeEdition = false
    @State private var selectedPhoto: PhotosPickerItem? = nil
    
    var body: some View {
        VStack(spacing: 25) {
            ZStack {
                Circle()
                    .fill(LinearGradient(colors: [.blue.opacity(0.3), .purple.opacity(0.3)],
                                         startPoint: .topLeading,
                                         endPoint: .bottomTrailing))
                    .frame(width: 140, height: 140)
                    .shadow(radius: 8)
                
                if let data = profileviewmodel.imageData,
                   let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 130, height: 130)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 3))
                } else {
                    Image (profileviewmodel.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.blue)
                }
                
                if modeEdition {
                    PhotosPicker(selection: $selectedPhoto, matching: .images) {
                        ZStack {
                            Circle()
                                .fill(Color.black.opacity(0.4))
                                .frame(width: 140, height: 140)
                            Image(systemName: "camera.fill")
                                .font(.system(size: 35))
                                .foregroundColor(.white)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.top, 50)
            .onChange(of: selectedPhoto) { _, newItem in
                if let newItem {
                    Task {
                        if let data = try? await newItem.loadTransferable(type: Data.self) {
                            profileviewmodel.imageData = data
                        }
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Nom")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                if modeEdition {
                    TextField("Entrez votre nom", text: $profileviewmodel.nom)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                } else {
                    Text(profileviewmodel.nom)
                        .font(.title3)
                        .bold()
                        .padding(.horizontal)
                }
            }
            
            VStack(spacing: 15) {
                HStack {
                    Text("Âge :")
                        .font(.headline)
                    Spacer()
                    if modeEdition {
                        Stepper(value: $profileviewmodel.age, in: 0...120) {
                            Text("\(profileviewmodel.age) ans")
                                .font(.title3)
                                .bold()
                        }
                        .labelsHidden()
                    } else {
                        Text("\(profileviewmodel.age) ans")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(.primary)
                    }
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Bio")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    if modeEdition {
                        TextEditor(text: $profileviewmodel.bio)
                            .font(.body)
                            .frame(height: 100)
                            .padding(8)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .padding(.horizontal)
                    } else {
                        Text(profileviewmodel.bio)
                            .font(.body)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
            }
            
            HStack(spacing: 20) {
                Button {
                    modeEdition.toggle()
                } label: {
                    Label(modeEdition ? "Terminer" : "Modifier",
                          systemImage: modeEdition ? "checkmark.circle.fill" : "pencil.circle.fill")
                }
                .buttonStyle(.borderedProminent)
                
                if !modeEdition {
                    Button {
                        profileviewmodel.age += 1
                    } label: {
                        Label("Vieillir", systemImage: "plus.circle.fill")
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button {
                        if profileviewmodel.age > 0 {
                            profileviewmodel.age -= 1
                        }
                    } label: {
                        Label("Rajeunir", systemImage: "minus.circle")
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .padding()
        .background(LinearGradient(colors: [.white, .blue.opacity(0.05)],
                                   startPoint: .top,
                                   endPoint: .bottom))
        .ignoresSafeArea(edges: .bottom)
    }
}
