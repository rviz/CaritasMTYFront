//
//  Recibos.swift
//  caritas
//
//  Created by Alumno on 04/09/23.
//

import SwiftUI
import Combine // Limite de caracteres en TextField


extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}

struct detallesView: View {
    @Binding var yaCargo: Bool
    //@Binding var ticket: ticket

    var ticket: ticket


    // Variables
    @Environment(\.dismiss) private var dismiss
    @State private var estadoFinal: String = ""
    @State private var comentarioAdicional: String = ""
    @State private var optionEstado: Int = 1
    
    // Información del recibo
    @State private var monto: Int = 0
    @State private var calle: String = "Sin información"
    @State private var colonia: String = "Sin información"
    @State private var numeroTelefonico: Int = 0
    @State private var notas: String = "Sin información"
    @State private var id: String = ""
    @State var guardado: Bool = false
    let textLimit = 150
    
    // Variables de la base de datos
    var calleBD: String {
        if ticket.housingReference.isEmpty {
            return "Sin información"
        } else {
            return ticket.housingReference
        }
    }
    
    var coloniaBD: String {
        if ticket.reprogramationComments.isEmpty {
            return "Sin información"
        } else {
            return ticket.reprogramationComments
        }
    }
    
    var donanteBD: String {
        if ticket.donorName.isEmpty {
            return "Sin información"
        } else {
            return ticket.donorName
        }
    }
    
    var telefonoBD: String {
        if ticket.cellPhone.isEmpty {
            return "Sin información"
        } else {
            return ticket.cellPhone
        }
    }
    
    var notasBD: String {
        if ticket.receiptComments.isEmpty {
            return "Sin información"
        } else {
            return ticket.receiptComments
        }
    }
    
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
                
                Text("$" + String(ticket.donationAmount))
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
                            Text(calleBD)
                        }.padding(.bottom, 10)
                        
                        HStack {
                            Text("Colonia:")
                                .fontWeight(.bold)
                            Text(coloniaBD)
                        }.padding(.bottom, 10)
                        
                        HStack {
                             Text("Donante:")
                                 .fontWeight(.bold)
                            Text(donanteBD)
                         }.padding(.bottom, 10)
                                             
                         HStack {
                             Text("Teléfono:")
                                 .fontWeight(.bold)
                             Text("+\(telefonoBD)")
                         }.padding(.bottom, 10)
                                             
                        HStack {
                            Text("Notas:")
                                .fontWeight(.bold)
                            Text(notasBD)
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
                    if(optionEstado == 1){
                        Color(red: 214/255, green: 214/255, blue: 214/255)
                                .frame(height: 50)
                                .frame(width: 330)
                                .cornerRadius(10) //
                                .offset(y:-55)

                        
                    }else if(optionEstado == 2){
                        Color.green
                                .frame(height: 50)
                                .frame(width: 330)
                                .cornerRadius(10) //
                                .offset(y:-55)
                    }else if(optionEstado == 3){
                        Color(red: 255/255, green: 0/255, blue: 0/255)                                .frame(height: 50)
                                .frame(width: 330)
                                .cornerRadius(10) //
                                .offset(y:-55)
                    }
                    
                    
                    
                    
                    
                    Picker(selection: $optionEstado, label: Text("Picker"))
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
                        )
                        .onChange(of: optionEstado){ value in
                            if(optionEstado == 1){
                                estadoFinal = "PENDING"
                            } else if (optionEstado == 2){
                                estadoFinal = "COLLECTED"
                            } else if (optionEstado == 3){
                                estadoFinal = "CONFLICT"
                            }
                            
                        }
                        .padding(.top, -70)
                        .zIndex(2)
                    
                   
                }
                
                // Campo de texto 1: Comentarios adicionales
                Text("Comentarios adicionales:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.bottom, .trailing], -3.0)
                    .padding(.leading, 35)
                    .padding(.top, -25)
                    .font(.title3)
                    .fontWeight(.regular)
                

                TextField("Comentario", text: $comentarioAdicional, axis: .vertical)
                    .onReceive(Just(comentarioAdicional)){ // Limita la cantidad de caracteres
                                           _ in limitText(textLimit)
                                       }
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
                    .onAppear() {
                        comentarioAdicional = ticket.collectorComments
                        if (ticket.state == "PENDING"){
                            optionEstado = 1
                        }
                        else if (ticket.state == "COLLECTED"){
                            optionEstado = 2
                        }
                        else if (ticket.state == "CONFLICT"){
                            optionEstado = 3
                        }
                    }
                
                
                // Botón: Guardar
                Button(action: {
                    hideKeyboard()
                    CambiarComment(id: ticket.id, comment: comentarioAdicional) { msg in
                        if let msg = msg, msg != "" {
                        }}
                    CambiarEstado(id: ticket.id, state: estadoFinal) { msg in
                        if let msg = msg, msg != "" {
                        }}
                    yaCargo = false
                    dismiss()
                    
                        }){
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
    func limitText(_ upper: Int){
           if comentarioAdicional.count > upper {
               comentarioAdicional = String(comentarioAdicional.prefix(upper))
           }
       }
    
}



struct Recibos_Previews: PreviewProvider {
    static var previews: some View {
        @State var yaCargo = false
       // @State var tickete : ticket = tickets()[0]
      
        detallesView(yaCargo: $yaCargo, ticket: tickets()[0])   }
}
