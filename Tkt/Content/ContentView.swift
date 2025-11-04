//
//  ContentView.swift
//  Tkt
//
//  Created by THIERRY-BELLEFOND Melvyn on 03/11/2025.
//

import SwiftUI

struct ContentView: View {
    @State var contentviewmodel = ContentViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text("Compteur : \(contentviewmodel.counter)")
                .font(.largeTitle)

            HStack {
                Button("+1") { contentviewmodel.counter += 1; Task { await contentviewmodel.fetchTodo() } }
                    .padding()
                Button("+10") { contentviewmodel.counter += 10; Task { await contentviewmodel.fetchTodo() } }
                    .padding()
                Button("-1") { contentviewmodel.counter -= 1; Task { await contentviewmodel.fetchTodo() } }
                    .padding()
                Button("-10") { contentviewmodel.counter -= 10; Task { await contentviewmodel.fetchTodo() } }
                    .padding()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            if let todo = contentviewmodel.todo {
                VStack(alignment: .leading, spacing: 10) {
                    Text("ID du Todo : \(todo.id)")
                    Text("Titre : \(todo.title)")
                    Text("Terminé : \(todo.completed ? "Oui" : "Non")")
                }
                .padding()
                .background(Color.green.opacity(0.2))
                .cornerRadius(8)
            } else {
                Text("Chargement du Todo…")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .task {
            await contentviewmodel.fetchTodo()
        }
    }
}
//test
