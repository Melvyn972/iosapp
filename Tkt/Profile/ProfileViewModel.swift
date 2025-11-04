//
//  ProfileViewModel.swift
//  Tkt
//
//  Created by THIERRY-BELLEFOND Melvyn on 03/11/2025.
//

import SwiftUI

@Observable
class ProfileViewModel {
    var nom: String = "LaSalle"
    var age: Int = 25
    var bio: String = "J'ai plus joué à GTA que RockstarGames"
    var imageName: ImageResource = .avatar
    var imageData: Data? = nil
}
