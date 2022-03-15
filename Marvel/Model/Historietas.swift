//
//  Historietas.swift
//  Marvel
//
//  Created by Maximiliano Morales on 15/03/2022.
//

import SwiftUI

struct APIHistorietasResultado: Codable {
    var data: APIHistorietas
}

struct APIHistorietas: Codable {
    var count: Int
    var results: [Historietas]
}

struct Historietas: Identifiable,Codable {
    var id: Int
    var name: String
    var description: String
    var thumbnail: [String: String]
    var urls: [[String: String]]
}
