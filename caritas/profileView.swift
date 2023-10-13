//
//  notificaView.swift
//  caritas
//
//  Created by Rudy on 07/09/23.
//

import SwiftUI
struct profileView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showingConfirmationAlert = false
    
    var body: some View {
        VStack {
            ZStack {
                // Barra de color y la imagen del repartidor en cuestión
                Color(red: 0, green: 156/255, blue: 171/255)
                    .edgesIgnoringSafeArea(.all)
                    .frame(width:500, height: 250)
                    .rotationEffect(Angle(degrees:-15))
                    .offset(y:-60)
                // Imagen del repartidor en cuestión
                Image(systemName: "face.smiling")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 130)
                    .foregroundColor(.black)
                    .background(.yellow)
                    .clipShape(Circle())

                    .offset(y:80)
            }.offset(y:-50)
            
            VStack{
                Text("¡Bienvenido ")
                +
                Text("usuario")
                .bold()
                +
                Text("!")
            }
            .font(.largeTitle)
            .offset(y: 20)
            Spacer()
            
            Button(action: {
                showingConfirmationAlert = true
            }) {
                Text("Cerrar Sesión")
                    .foregroundColor(Color.red)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding(.bottom, 25)
            }
            .alert(isPresented: $showingConfirmationAlert) {
                Alert(
                    title: Text("¿Cerrar Sesión?"),
                    message: Text("¿Estás seguro de que deseas cerrar sesión?"),
                    primaryButton: .destructive(Text("Sí")) {
                        dismiss() // Lógica para cerrar sesión: dismiss la vista actual
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .padding()
    }
}

struct profileView_Previews: PreviewProvider {
    static var previews: some View {
        profileView()
    }
}

