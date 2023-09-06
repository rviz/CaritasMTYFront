//
//  Recibos.swift
//  caritas
//
//  Created by Alumno on 04/09/23.
//

import SwiftUI

struct detallesView: View {
    
    // Variables
    @State private var estadoFinal: String = ""
    @State private var comentarioAdicional: String = ""
    @State private var option: Int = 1
    
    // Información del recibo
    @State private var calle: String = "Sin información"
    @State private var colonia: String = "Sin información"
    @State private var monto: Int = 0
    @State private var notas: String = "Sin información"
    
    
    var body: some View {
        
        VStack{
            
            // Impresión de información
            VStack{
                
                ZStack{
                    
                    // Barra de color
                    Color(red: 0, green: 156/255, blue: 171/255)
                        .edgesIgnoringSafeArea(.all)
                        .frame(height: 130)
                        .frame(height: .infinity)
                        .offset(y:-50)
                    
                    Text("Detalles")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                        .offset(y:-30)
                        .foregroundColor(Color.white) 
                    
                }.offset(y:40)
                
            }.padding(0)
            
            HStack{
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    HStack {
                        Text("Calle:")
                            .font(.title3)
                            .fontWeight(.bold)
                        Text(calle)
                            .font(.title3)
                    }.padding(.bottom, 10)
                    
                    HStack {
                        Text("Colonia:")
                            .font(.title3)
                            .fontWeight(.bold)
                        Text(colonia)
                            .font(.title3)
                    }.padding(.bottom, 10)
                    
                    HStack {
                        Text("Monto:")
                            .font(.title3)
                            .fontWeight(.bold)
                        Text("$" + String(monto))
                            .font(.title3)
                    }.padding(.bottom, 10)
                    
                    HStack {
                        Text("Notas:")
                            .font(.title3)
                            .fontWeight(.bold)
                        Text(notas)
                            .font(.title3)
                    }.padding(.bottom, 10)
                }
                .padding(.top, 100)
                .padding(.bottom, 25)
            }
            .padding(.leading, -95)
            .offset(y:-50)
            .padding(.top, -5)
            
            // Opciones: Estados
            Picker(selection: $option, label: Text("Picker"))
            {
                Text("No cobrado").tag(1)
                Text("Cobrado").tag(2)
                Text("Conflicto").tag(3)
                
            }.padding(.top, 5.0)
                .pickerStyle(.segmented)
                .frame(width: 330)
                .onChange(of: option){ value in
                    
                    if(option == 1){
                        estadoFinal = "No cobrado"
                    } else if (option == 2){
                        estadoFinal = "Cobrado"
                    } else if (option == 3){
                        estadoFinal = "Conflicto"
                    }
                    
                } .padding(.bottom, 35)
                .padding(.top, -55)
            
            // Campo de texto 1: Comentarios adicionales
            Text("Comentarios adicionales:")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title3)
                .fontWeight(.bold)
                .padding([.bottom, .trailing], -3.0)
                .padding(.leading, 35)
            
            TextField("", text: $comentarioAdicional)
                .frame(width: 330, height: 100)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .font(.body)
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
            
            // Botón: Guardar
            Button(action: {
                // Acción que deseas realizar cuando se presione el botón
            }) {
                Text("Guardar")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(width: 300, height: 60)
                    .foregroundColor(Color.white) // Establece el color del texto en blanco
            }
            .buttonStyle(.borderedProminent)
            .tint(Color(red: 0, green: 156/255, blue: 171/255))
            .padding(.top, 28)
            
            Spacer()
            
        }
        
    }}

struct Recibos_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            detallesView()}    }
}