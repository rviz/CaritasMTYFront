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
            Text("Hola (nombre)")
                .font(.largeTitle)
            NavigationLink(destination: loginView()){
                Text("sissss")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .font(.body)
            }
        }
    }
}

struct profileView_Previews: PreviewProvider {
    static var previews: some View {
        profileView()
    }
}
