//
//  ContentView.swift
//  caritas
//
//  Created by Alumno on 04/09/23.
//

import SwiftUI

struct loginView: View {
    
    //Tipo de usuario
    @State private var coordinador: Bool = false
    @State private var option: Int = 0

    // Variables de ingreso
    @State private var usuario: String = ""
    @State private var contraseña: String = ""
    
    // Variables API
    @State private var usuarioCorrecto: String = ""
    @State private var contraseñaCorrecto: String = ""
    
    @State private var showAlert = false
    @State private var isDisabled = false


    var body: some View {
        
        NavigationStack{
            
            
            ZStack{
                
                // Fondo de pantalla
                //            Color.init(red: 0, green: 156/255, blue: 171/255)
                //                .edgesIgnoringSafeArea(.all)
                //                .frame(height: .infinity)
                //
                LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 156/255, blue: 171/255), Color(red: 0/255, green: 59/255, blue: 92/255, opacity: 255.0)]), startPoint: .top, endPoint: .bottomLeading)
                    .edgesIgnoringSafeArea(.all)
                
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
                        .padding(.leading, 34)
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
                        .padding(.leading, 34)
                        .padding(.top, 25)
                        .foregroundColor(Color.white)
                    
                    
                    SecureField("", text: $contraseña)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 330)
                        .font(.title)
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                        
                    
                    
                    // Opciones: Estados
                    Picker(selection: $option, label: Text("Picker"))
                    {
                        Text("Recolector").tag(1)
                        Text("Coordinador").tag(2)
                        
                    }
                    .pickerStyle(.segmented)
                        .frame(width: 330)
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(10) // Añade esquinas redondeadas al fondo
                        .onChange(of: option){ value in
                            
                            if(option == 1){
                                coordinador = false
                            } else if (option == 2){
                                coordinador = true
                            }
                            
                        } .padding(.top, 20)
                    
                    //comentario
                    // Botón: Ingresar
                    Button(action: {
                        if(contraseña == contraseñaCorrecto) && (usuario == usuarioCorrecto){
                            
                        } else {
                            showAlert.toggle()
                        }
                    }) {
                        NavigationLink("INGRESAR"){
                                contentView()
                        }
                            .font(.title3)
                            .fontWeight(.regular)
                            .frame(width: 300, height: 50)
                            .foregroundColor(Color.white)
                        
                        
                    }.alert("La contraseña y/o usuario son inválidos. Por favor vuelve a intentarlo.", isPresented: $showAlert){
                        Button("OK"){}
                        
                    }
                    
                    .buttonStyle(.borderedProminent)
                    .tint(Color(hue: 0.543, saturation: 0.272, brightness: 0.931, opacity: 0.3))
                    .padding(.top, 105)
                    
                    Spacer()
                    
                    
    
                    VStack{
                        Color.init(red: 0, green: 59/255, blue: 92/255)
                            .edgesIgnoringSafeArea(.all)
                            .offset(y:20)
                            .frame(height: 20)
                    }
                    
                } .padding(0)
                
                
            }
            
            
            
        }  .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        loginView()
    }
}

