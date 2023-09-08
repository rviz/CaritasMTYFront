//
//  contentView.swift
//  caritas
//
//  Created by Alumno on 05/09/23.
//

import SwiftUI

struct contentView: View {
    
    var body: some View {
                
        TabView{
            Group{
                listadoView()
                    .tabItem {
                        Label("Tickets", systemImage: "ticket")
                    }
                profileView()
                    .tabItem {
                        Label("Perfil", systemImage: "person.circle")
                    }
            }.toolbarBackground(.visible, for: .tabBar)
        }.tint(Color(red: 0, green: 156/255, blue: 171/255))
            .toolbar(.hidden)
            
            


    }
}

struct contentView_Previews: PreviewProvider {
    static var previews: some View {
        contentView()
    }
}
