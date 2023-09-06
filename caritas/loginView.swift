//
//  ContentView.swift
//  caritas
//
//  Created by Alumno on 04/09/23.
//

import SwiftUI

struct loginView: View {
    
    @State private var usuario: String = " "
    @State private var contraseña: String = " "

    var body: some View {
        
        ZStack{
            
            // Fondo de pantalla
//            Color.init(red: 0, green: 156/255, blue: 171/255)
//                .edgesIgnoringSafeArea(.all)
//                .frame(height: .infinity)
//
            LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 156/255, blue: 171/255), Color(red: 0/255, green: 59/255, blue: 92/255, opacity: 255.0)]), startPoint: .top, endPoint: .bottomLeading)
                       .edgesIgnoringSafeArea(.all)
                       .frame(height: .infinity)
            
            VStack{
                
                Image("logocaritasBlanco2")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250)
                    .padding(.bottom, 100)
                    .padding(.top, 70)
                                
                // Campo de texto 1: Usuario
                Text("Usuario:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title3)
                    .fontWeight(.regular)
                    .padding([.bottom, .trailing], -3.0)
                    .padding(.leading, 45)
                    .foregroundColor(Color.white)
                    
                TextField("", text: $usuario)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 330)
                    .font(.title)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                
                // Campo de texto 2: Contraseña
                Text("Contraseña:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title3)
                    .fontWeight(.regular)
                    .padding([.bottom, .trailing], -3.0)
                    .padding(.leading, 45)
                    .padding(.top, 25)
                    .foregroundColor(Color.white)

                
                SecureField("", text: $contraseña)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 330)
                    .font(.title)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)

                // Botón: Ingresar
                Button(action: {
                    // Acción que deseas realizar cuando se presione el botón
                }) {
                    Text("INGRESAR")
                        .font(.title3)
                        .fontWeight(.regular)
                        .frame(width: 400, height: 50)
                        .foregroundColor(Color.white) 
                }
                .buttonStyle(.borderedProminent)
                .tint(Color(hue: 0.543, saturation: 0.272, brightness: 0.931, opacity: 0.3))
                .padding(.top, 120)
                
                Spacer()
                
              
                
                VStack{
                    Color.init(red: 0, green: 59/255, blue: 92/255)
                        .edgesIgnoringSafeArea(.all)
                        .offset(y:20)
                        .frame(height: 20)
                }
                
            } .padding(0)
            
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        loginView()
    }
}
