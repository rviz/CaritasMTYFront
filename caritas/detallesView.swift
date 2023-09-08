//
//  Recibos.swift
//  caritas
//
//  Created by Alumno on 04/09/23.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}

struct detallesView: View {

    // Variables
    @State private var estadoFinal: String = ""
    @State private var comentarioAdicional: String = ""
    @State private var option: Int = 1
    
    // Información del recibo
    @State private var monto: Int = 0
    @State private var calle: String = "Sin información"
    @State private var colonia: String = "Sin información"
    @State private var monto: Int = 0
    @State private var notas: String = "Sin información"
    @State private var id: String = ""

    
    var body: some View {
        
        VStack{
            
            // Impresión de información
            VStack{
                
                
                ZStack{
                    
                    // Barra de color
                    Color(red: 0, green: 156/255, blue: 171/255)
                        .edgesIgnoringSafeArea(.all)
                        .frame(height: 80)
                        .offset(y:-50)
                    
                    Text("Detalles")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                        .offset(y:-40)
                        .foregroundColor(Color.white)
                    
                }
                
            }.padding(0)
            
            ScrollView {
                
                Text("$" + String(monto))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 40)
                    .padding(.bottom, 30)
                
                // Botón: Guardar
                Button(action: {
                    // Acción que deseas realizar cuando se presione el botón
                }) {
                    Text("Ver mapa")
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(width: 300, height: 40)
                        .foregroundColor(Color.white)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color(red: 0, green: 156/255, blue: 171/255))
                .padding(.bottom, -15)

                HStack{
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        HStack {
                            Text("Calle:")
                                .fontWeight(.bold)
                            Text(calle)
                        }.padding(.bottom, 10)
                        
                        HStack {
                            Text("Colonia:")
                                .fontWeight(.bold)
                            Text(colonia)
                        }.padding(.bottom, 10)
                        
                        HStack {
                            Text("Notas:")
                                .fontWeight(.bold)
                            Text(notas)
                        }.padding(.bottom, 10)
                    }
                    .padding(.top, 100)
                    .padding(.bottom, 25)
                }
                .padding(.leading, -95)
                .offset(y:-50)
                .padding(.top, -5)
                
                // Opciones: Estados
                ZStack{
                    // Barra de color
                    if(option == 1){
                        Color(red: 214/255, green: 214/255, blue: 214/255)
                                .frame(height: 50)
                                .frame(width: 330)
                                .cornerRadius(10) //
                                .offset(y:-55)

                        
                    }else if(option == 2){
                        Color.green
                                .frame(height: 50)
                                .frame(width: 330)
                                .cornerRadius(10) //
                                .offset(y:-55)
                    }else if(option == 3){
                        Color(red: 214/255, green: 0/255, blue: 0/255)                                .frame(height: 50)
                                .frame(width: 330)
                                .cornerRadius(10) //
                                .offset(y:-55)
                    }
                    
                    
                    Picker(selection: $option, label: Text("Picker"))
                    {
                        Text("No cobrado").tag(1)
                        Text("Cobrado").tag(2)
                        Text("Conflicto").tag(3)
                        
                    }.pickerStyle(.segmented)
                        .frame(width: 310)
                        .background(
                            // Apply a background color to the selected segment
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.white) // Change this color to your desired color
                                .padding(.horizontal, 0) // Adjust the padding as needed
                        )
                        .onChange(of: option){ value in
                            
                            if(option == 1){
                                estadoFinal = "No cobrado"
                            } else if (option == 2){
                                estadoFinal = "Cobrado"
                            } else if (option == 3){
                                estadoFinal = "Conflicto"
                            }
                            
                        }
                        .padding(.top, -70)
                        .zIndex(2)
                    
                   
                }
                
                // Campo de texto 1: Comentarios adicionales
                Text("Comentarios adicionales:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding([.bottom, .trailing], -3.0)
                    .padding(.leading, 35)
                    .padding(.top, -25)
                
                TextField("Comentario", text: $comentarioAdicional)
                    .frame(width: 323, height: 45)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                
                // Botón: Guardar
                Button(action: {
                    hideKeyboard()
                    // Acción que deseas realizar cuando se presione el botón
                }) {
                    Text("Guardar")
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(width: 300, height: 40)
                        .foregroundColor(Color.white) // Establece el color del texto en blanco
                }
                .buttonStyle(.borderedProminent)
                .tint(Color(red: 0, green: 156/255, blue: 171/255))
                .padding(.top, 23)
                
                Spacer()
                
            } .padding(.top, -58)  // scroll
            
        }
        
    }
    
}

struct Recibos_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            detallesView()}    }
}
