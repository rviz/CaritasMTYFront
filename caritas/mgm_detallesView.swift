//
//  ManDetallesView.swift
//  caritas
//
//  Created by Rudy on 25/09/23.
//

import SwiftUI


struct mgm_detallesView: View {
    // Variables
    
    @State private var comentarioAdicional: String = ""
    @State private var optionEstado = 1
    
    // Información del recibo
    @State private var monto: Int = 0
    @State private var calle: String = "Sin información, colonia patito, rincon perezoso #345"
    @State private var notas: String = "Sin información"
    
    // Información del recibo para el manager
    @State private var idRecibo: Int = 69
    @State private var estadoFinal: String = ""
    @State private var estado: String = ""

    
    
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

                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text("ID Recibo:")
                                .fontWeight(.bold)
                            Text(String(idRecibo))
                        }.padding(.bottom, 10)
                        HStack {
                            Text("Calle:")
                                .fontWeight(.bold)
                            Text(calle)
                        }.padding(.bottom, 10)
                        HStack {
                            Text("Notas:")
                                .fontWeight(.bold)
                            Text(notas)
                        }.padding(.bottom, 10)
                        HStack {
                            Text("Estado:")
                                .fontWeight(.bold)
                            Text(estado)
                                .foregroundColor(getTextColor())
                        }.padding(.bottom, 10)
                            .onAppear(){
                                if(optionEstado == 1){
                                    estado = "No cobrado"
                                } else if (optionEstado == 2){
                                    estado = "Cobrado"
                                } else if (optionEstado == 3){
                                    estado = "Conflicto"
                                }
                            }
                            
                    }
                    .padding(.top, 100)
                    .padding(.bottom, 25)
                    .offset(y:-50)
                    .frame(maxWidth: 380)
                
               
                
                
                // Campo de texto 1: Comentarios adicionales
                Text("Comentarios adicionales:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.bottom, .trailing], -3.0)
                    .padding(.leading, 35)
                    .padding(.top, -25)
                    .font(.title3)
                    .fontWeight(.regular)
                
                TextField("Comentario", text: $comentarioAdicional, axis: .vertical)
                    .onTapGesture {
                        
                    }
                    .padding(.leading)
                    .padding(.top,5)
                    .padding(.bottom, 5)
                    .frame(width: 323)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
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
    private func getTextColor() -> Color {
        if optionEstado == 1 {
            return Color.gray
        } else if optionEstado == 2 {
            return Color.green
        } else if optionEstado == 3 {
            return Color.red
        } else {
            return Color.black // You can choose a default color if needed
        }
    }
    
}




struct mgm_detallesView_Previews: PreviewProvider {
    static var previews: some View {
        mgm_detallesView()
    }
}
