//
//  HomeViewModel.swift
//  Marvel
//
//  Created by Maximiliano Morales on 15/03/2022.
//

import SwiftUI
import Combine
import CryptoKit

class HomeViewModel: ObservableObject{
    @Published var searchQuery = ""
    
    var searchCancellable: AnyCancellable? = nil
    
    @Published var fetchedPersonajes: [Personajes]? = nil
    
    init(){
        searchCancellable = $searchQuery
            .removeDuplicates()
            .debounce(for: 0.6, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                
                if str == ""{
                    self.fetchedPersonajes = nil
                }
                else{
                    self.searchPersonajes()
                    print(str)
                }
            })
    }

    func searchPersonajes(){
        
        let originalQuery = searchQuery.replacingOccurrences(of: " ", with: "%20")
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(privateKey)\(publicKey)")
        let url = "https://gateway.marvel.com:443/v1/public/characters?nameStartsWith=\(originalQuery)&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
    
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!){ (data, response, err) in
            if let error = err{
                print(error.localizedDescription)
                return
            }
            
            guard let APIData = data else{
                print("No hay datos")
                return
            }
            do{
                let personajes = try JSONDecoder().decode(APIPersonajesResultado.self, from: APIData)
                
                DispatchQueue.main.async {
                    
                    if self.fetchedPersonajes == nil {
                        self.fetchedPersonajes = personajes.data.results
                    }
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
    func MD5(data: String)->String{
        
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        return hash.map{
            String(format: "%02hhx", $0)
        }
        .joined()
    }
}
