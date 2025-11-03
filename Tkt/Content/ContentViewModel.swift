//
//  ContentViewModel.swift
//  Tkt
//
//  Created by THIERRY-BELLEFOND Melvyn on 03/11/2025.
//
import SwiftUI

@Observable
class ContentViewModel {
    var counter: Int = 0
    var todo: Todo?

    func fetchTodo() async {
        let id = counter == 0 ? 1 : counter
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/\(id)") else { return }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { return }
            let decoded = try JSONDecoder().decode(Todo.self, from: data)
            todo = decoded
            print(decoded)
        } catch {
            print(error)
        }
    }
}
