//
//  TabNavigation.swift
//  SixtApp
//
//  Created by Manuel Crovetto on 23/02/2023.
//

import SwiftUI

struct TabNavigation: View {
    var body: some View {
        TabView {
            CarListScreen()
                .tabItem {
                    Image(systemName: "list.bullet.clipboard")
                    Text("Car list")
            
                }
                
            CarMapScreen()
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
        }
        
        .accentColor(.black)
    }
}

struct TabNavigation_Previews: PreviewProvider {
    static var previews: some View {
        TabNavigation()
    }
}
