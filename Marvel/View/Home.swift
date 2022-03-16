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

            PersonajesView()
                .environmentObject(homeData)
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
