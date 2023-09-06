//
//  listadoView.swift
//  caritas
//
//  Created by Alumno on 05/09/23.
//

import SwiftUI

struct listadoView: View {
    // Variables
    @State private var option: Int = 1
    @State private var filtroID: String = ""
    @State private var tipoFiltro: String = ""
    @State private var lista: Array<Recibo> = []

    
    
    var body: some View {
        
        VStack{
                VStack{
            
                ZStack{
                    // Barra de color
                    Color(red: 0, green: 156/255, blue: 171/255)
                        .edgesIgnoringSafeArea(.all)
                        .frame(height: 130)
                        .frame(height: .infinity)
                        .offset(y:-50)
                    
                    Text("Tickets asignados")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                        .offset(y:-30)
                        .foregroundColor(Color.white)
                    
                }.offset(y:40)
            }
            
            HStack{
                
                VStack() {
                    TextField("Buscar por ID", text: $filtroID)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 330)
                        .font(.title)
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                    Picker(selection: $option, label: Text("Picker"))
                    {
                        Text("Zona").tag(1)
                        Text("Colonia").tag(2)
                        Text("Código Postal").tag(3)
                        
                    }
                    .padding(.top, 3.0)
                        .pickerStyle(.segmented)
                        .frame(width: 330)
                        .onChange(of: option){ value in
                            
                            if(option == 1){
                                tipoFiltro = "Zona"
                            } else if (option == 2){
                                tipoFiltro = "Colonia"
                            } else if (option == 3){
                                tipoFiltro = "CodigoPostal"
                            }
                            
                        }
        
                    List (lista){
                        listaItem in
                        Text(listaItem.title)
                    }.onAppear(){
                        lista = callAPILista()
                    }
                        
                    
                }
            }
            
            
            // Opciones: Estados
            
            // Campo de texto 1: Comentarios adicionales
           
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

struct listadoView_Previews: PreviewProvider {
    static var previews: some View {
        listadoView()
    }
}
