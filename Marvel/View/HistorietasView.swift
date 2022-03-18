//
//  HistorietasView.swift
//  Marvel
//
//  Created by Maximiliano Morales on 15/03/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct HistorietasView: View {
    @EnvironmentObject var homeData: HomeViewModel
    
    var body: some View {
        
        NavigationView{
            
            ScrollView(.vertical,showsIndicators: false , content: {
                if homeData.fetchedHistorietas.isEmpty{
                        ProgressView()
                            .padding(.top,30)
                }
                else{
                    VStack(spacing: 15){
                        ForEach(homeData.fetchedHistorietas){data in
                            HistorietaRowView(historieta: data)

                        }
                        if homeData.offset == homeData.fetchedHistorietas.count{
                            ProgressView()
                                .padding(.vertical)
                                .onAppear(perform: {
                                    print("Buscando nuevos datos...")
                                    homeData.fetchHistorietas()
                                })
                        }
                        else{
                            GeometryReader{reader -> Color in
                                let minY = reader.frame(in: .global).minY
                                let height = UIScreen.main.bounds.height / 1.3
                                
                                if !homeData.fetchedHistorietas.isEmpty && minY < height{
                                    
                                    DispatchQueue.main.async {
                                        homeData.offset = homeData.fetchedHistorietas.count
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
                .navigationTitle("Historietas")
        }
        .onAppear(perform: {
            if homeData.fetchedHistorietas.isEmpty{
                homeData.fetchHistorietas()
            }
        })
    }
}

struct HistorietasView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct HistorietaRowView: View {
    var historieta: Historietas
    
    var body: some View{
        HStack(alignment: .top, spacing: 15){
            
            WebImage(url: extractImage(data: historieta.thumbnail))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 8, content: {
                
                Text(historieta.title)
                    .font(.title3)
                    .fontWeight(.bold)
                
                if let description = historieta.description{
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(4)
                        .multilineTextAlignment(.leading)
                }
                
                
                HStack(spacing: 6){
                    
                    ForEach(historieta.urls, id: \.self){ data in
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
