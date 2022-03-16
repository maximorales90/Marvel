//
//  HistorietasView.swift
//  Marvel
//
//  Created by Maximiliano Morales on 15/03/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct PersonajesView: View {
    @EnvironmentObject var homeData: HomeViewModel
    
    var body: some View {
        
        NavigationView{
            
            ScrollView(.vertical,showsIndicators: false , content: {
                if homeData.fetchedPersonajes.isEmpty{
                        ProgressView()
                            .padding(.top,30)
                }
                else{
                    VStack(spacing: 15){
                        ForEach(homeData.fetchedPersonajes){data in
                            PersonajesRowView(personaje: data)

                        }
                        if homeData.offset == homeData.fetchedPersonajes.count{
                            ProgressView()
                                .padding(.vertical)
                                .onAppear(perform: {
                                    print("Buscando nuevos datos...")
                                    homeData.fetchPersonajes()
                                })
                        }
                        else{
                            GeometryReader{reader -> Color in
                                let minY = reader.frame(in: .global).minY
                                let height = UIScreen.main.bounds.height / 1.3
                                
                                if !homeData.fetchedPersonajes.isEmpty && minY < height{
                                    
                                    DispatchQueue.main.async {
                                        homeData.offset = homeData.fetchedPersonajes.count
                                    }
                                }
                                return Color.clear
                        }
                            .frame(width: 20, height: 20)
                        }
                        
                    }
                    .padding(.vertical)
                }
            })
                .navigationTitle("Personajes de Marvel")
        }
        .onAppear(perform: {
            if homeData.fetchedPersonajes.isEmpty{
                homeData.fetchPersonajes()
            }
        })
    }
}

struct PersonajesView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct PersonajesRowView: View {
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
