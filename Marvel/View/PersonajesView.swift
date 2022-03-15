//
//  ContentView.swift
//  Marvel
//
//  Created by Maximiliano Morales on 14/03/2022.
//

import SwiftUI
import SDWebImageSwiftUI

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
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
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
                            PersonajeRowView(personaje: data)
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


struct PersonajeRowView: View {
    var personaje: Personajes
    
    var body: some View{
        HStack(alignment: .top, spacing: 15){
            
            WebImage(url: extractImage(data: personaje.thumbnail))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 8, content: {
                
                Text(personaje.name)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text(personaje.description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(4)
                    .multilineTextAlignment(.leading)
                
                HStack(spacing: 6){
                    
                    ForEach(personaje.urls, id: \.self){ data in
                        NavigationLink(
                            destination: WebView(url: extractURL(data: data))
                                .navigationTitle(extractURLType(data: data)),
                            label: {
                                Text(extractURLType(data: data))
                            })
                    }
                }
                

                
            })
            Spacer(minLength: 0)
        }
        .padding(.horizontal)
    }
    
    func extractImage(data: [String: String])->URL{
        
        let path = data["path"] ?? ""
        print(path)
        let ext = data["extension"] ?? ""
        print(ext)
        
        return URL(string: "\(path).\(ext)")!

    }
                   
    func extractURL(data: [String: String])->URL{
                       
        let url = data["url"] ?? ""
        print(url)
                       
        return URL(string: url)!

    }
    
    func extractURLType(data: [String: String])->String{
                       
        let type = data["type"] ?? ""
        print(type)
                       
        return type.capitalized

    }
}
