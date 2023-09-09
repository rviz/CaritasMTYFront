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
            ZStack{
                // Barra de color
                Color(red: 0, green: 156/255, blue: 171/255)
                    .edgesIgnoringSafeArea(.all)
                    .frame(width:500, height: 250)
                    .rotationEffect(Angle(degrees:-15))
                    .offset(y:-50)
                // Imagen del repartidor en cuestión
                Image(systemName: "person.circle")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 130)
                    .background(Color.white)
                    .clipShape(Circle())
                    .offset(y:80)
            }.offset(y:-50)
            Text("Hola,")
                .font(.largeTitle)
            Text("(fullname)")
                .font(.largeTitle)
            Spacer()
            
            NavigationLink(destination: loginView()){
                Text("Cerrar Sesión")
                    .foregroundColor(Color.red)
            }.offset(y:-25)
        }
    }
}

struct profileView_Previews: PreviewProvider {
    static var previews: some View {
        profileView()
    }
}
