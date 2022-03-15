//
//  Home.swift
//  Marvel
//
//  Created by Maximiliano Morales on 15/03/2022.
//

import SwiftUI

struct Home:  View {
    @StateObject var homeData = HomeViewModel()
    var body: some View {
        TabView{
            PersonajesView()
                .tabItem{
                    Image(systemName:  "person.3.fill")
                    Text("Personajes")
                }
            HistorietasView()
                .tabItem{
                    Image(systemName:  "books.vertical.fill")
                    Text("Historietas")
                }
        }
    }
}
