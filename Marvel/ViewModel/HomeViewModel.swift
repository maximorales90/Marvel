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
                    
                } else{
                    print(str)
                }
            })
    }

    func searchPersonajes(){
        
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(privateKey)\(publicKey)")
        let url = "https://gateway.marvel.com:443/v1/public/characters?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!){ (data, _, err) in
            if let error = err{
                print(error.localizedDescription)
                return
            }
            
            guard let APIData = data else{
                print("No hay datos")
                return
            }
            do{
                
            }
            catch{
                print(error.localizedDescription)
            }
        }
        
    }
    
    func MD5(data: String)->String{
        
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        return hash.map{
            String(format: "%02hfx", $0)
        }
        .joined()
    }
}
