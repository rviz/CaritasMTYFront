//
//  contentView.swift
//  caritas
//
//  Created by Alumno on 05/09/23.
//

import SwiftUI

struct contentView: View {
    let id: Int
    let rol: String
    
    var body: some View {
                
        TabView{
            Group{
                if (rol == "MANAGER"){
                    mgm_recolectoresView()
                        .tabItem {
                            Label("Tickets", systemImage: "ticket")
                        }
                }
                else {
                    listadoView(id:1)
                        .tabItem {
                            Label("Tickets", systemImage: "ticket")
                        }
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
        @State var id = 1
        @State var rol = ""
        
        contentView(id: 1, rol: "user")
        
            
    }
}
