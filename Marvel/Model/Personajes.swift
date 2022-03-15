//
//  Personajes.swift
//  Marvel
//
//  Created by Maximiliano Morales on 15/03/2022.
//

import SwiftUI

struct APIResultado: Codable {
    var data: APIPersonajes
}

struct APIPersonajes: Codable {
    var count: Int
    var results: [Personajes]
}

struct Personajes: Identifiable,Codable {
    var id: Int
    var name: String
    var description: String
    var thumbnail: [String: String]
    var urls: [[String: String]]
}



