//
//  HomeViewModel.swift
//  Marvel
//
//  Created by Maximiliano Morales on 15/03/2022.
//

import SwiftUI
import Combine
import MapKit

class HomeViewModel: ObservableObject{
    @Published var searchQuery = ""
    
    var searchCancellable: AnyCancellable? = nil
    
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

    
}
