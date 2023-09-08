//
//  notificaView.swift
//  caritas
//
//  Created by Rudy on 07/09/23.
//

import SwiftUI

struct profileView: View {
    var body: some View {

        VStack{
            Spacer()
            Image(systemName: "person.circle")
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
            Text("Hola (nombre)")
                .font(.largeTitle)
            Spacer()
            
            NavigationLink(destination: loginView()){
                Text("Cerrar Sesión")
                    
            }
        }
    }
}

struct profileView_Previews: PreviewProvider {
    static var previews: some View {
        profileView()
    }
}
