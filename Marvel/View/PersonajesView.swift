//
//  ContentView.swift
//  Marvel
//
//  Created by Maximiliano Morales on 14/03/2022.
//

import SwiftUI

struct PersonajesView: View {
    @EnvironmentObject var homeData: HomeViewModel
    
    var body: some View {
        NavigationView{
            
            ScrollView(.vertical,showsIndicators: false , content: {
                VStack(spacing: 15){
                    HStack(spacing: 10){
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Búsqueda de Personajes", text: $homeData.searchQuery)
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    .background(Color.white)
                    
                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: -5, y: -5)
                }
                .padding()
                
                if let personajes = homeData.fetchedPersonajes{
                    
                    if  personajes.isEmpty{
                        Text("No se han encontrado resultados")
                            .padding(.top,20)
                    }
                    else{
                        ForEach(personajes){data in
                            Text(data.name)
                        }

                    }
                }
                else{
                    
                    if homeData.searchQuery != ""{
                        ProgressView()
                            .padding(.top,20)
                    }
                }
            })
                .navigationTitle("Marvel")
        }
    }
}

struct PersonajesView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
