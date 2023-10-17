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
    
    
    @State private var coordinates: String = "Cargando..."
    @State var lat: Double = 0.0
    @State var lng: Double = 0.0
    
    // Variables
    @Environment(\.dismiss) private var dismiss
    @State private var estadoFinal: String = ""
    @State private var comentarioAdicional: String = ""
    @State private var optionEstado: Int = 1
    
    // Información del recibo
    @State private var monto: Int = 0
    @State private var calle: String = ""
    @State private var colonia: String = ""
    @State private var numeroTelefonico: Int = 0
    @State private var notas: String = ""
    @State private var id: String = ""
    @State var guardado: Bool = false
    @State private var commentsColor: Color = .black
    @State private var showingConfirmationAlert = false
    @State private var isValid: Bool = false

    
    // Limite de palabras en campo de comentarios
    let textLimit = 150
    
    // Bloqueo de picker
    @State private var isPickerEnabled = true
    @State private var isCommentEnabled = true
    

    // Variables de la base de datos
    var idBD: String {
        if ticket.id == 0 {
            return "Sin información"
        } else {
            return String(ticket.id)
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
    
    var calleBD: String {
        if ticket.street.isEmpty {
            return "Sin información"
        } else {
            return ticket.street
        }
    }
    
    var coloniaBD: String {
        if ticket.suburb.isEmpty {
            return "Sin información, sin info, sin informaciones, no disponibles."
        } else {
            return ticket.suburb
        }
    }
    
    // Variables de la base de datos
    var numeroCasaBD: String {
        if ticket.houseNumber == 0 {
            return "Sin información"
        } else {
            return String(ticket.houseNumber)
        }
    }
    
    // Variables de la base de datos
    var municipioBD: String {
        if ticket.municipality.isEmpty {
            return "Sin información"
        } else {
            return ticket.municipality
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
        NavigationStack{
            
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
                    //.padding(.top,15)
                    
                }.padding(0)
                
                ScrollView {
                    
                    Text("$" + String(ticket.donationAmount))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.top, 40)
                        .padding(.bottom, 40)
                    

/*                    Button(action: {
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
                    .padding(.top, -25)
                    .onTapGesture {
                        mapaView(latitud: 25.649991, longitud: -100.29)
                    }
*/
                    Button{
                        self.isValid = true
                        
                        //loadCoordinates()
                       
                        
                    } label: {
                        Text("Ver mapa")
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(width: 300, height: 40)
                            .foregroundColor(Color.white)
                        
                    }
                        .navigationDestination(isPresented: $isValid){
                            mapaView(latitud: lat, longitud: lng)
                        }
                        .onAppear(){
                            loadCoordinates()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color(red: 0, green: 156/255, blue: 171/255))
                        .padding(.top, -25)
                    HStack{
                        
                        VStack(alignment: .leading, spacing: 0) {
                            VStack {
                                Text("Donante: ")
                                    .fontWeight(.bold)
                                +
                                Text(donanteBD)
                            }.padding(.bottom, 10)
                            VStack {
                                Text("Teléfono: ")
                                    .fontWeight(.bold)
                                +
                                Text(telefonoBD)
                            }.padding(.bottom, 10)
                            Divider()
                                .padding(.bottom, 10)
                            VStack {
                                Text("Dirección: ")
                                    .fontWeight(.bold)
                                +
                                Text(calleBD + ", \(coloniaBD), #\(numeroCasaBD)")
                            }.padding(.bottom, 10)
                            
                            VStack {
                                Text("Municipio: ")
                                    .fontWeight(.bold)
                                +
                                Text(municipioBD)
                            }.padding(.bottom, 10)
                            
                            
                            
                            VStack {
                                Text("Notas: ")
                                    .fontWeight(.bold)
                                +
                                Text(notasBD)
                            }
                        }
                        .padding(.top, 75)
                        .padding(.bottom, 15)
                        .frame(maxWidth: 340)
                        .font(.system(size: 18))
                    }
                    .offset(y:-50)
                    .padding(.top,-3)
                    .padding(.leading, 30)
                    
                    // Opciones: Estados
                    ZStack{
                        // Barra de color
                        if(optionEstado == 1){
                            Color(red: 214/255, green: 214/255, blue: 214/255)
                                .frame(width: 330, height: 55)
                                .cornerRadius(8) //
                                .offset(y:-45)
                        }else if(optionEstado == 2){
                            Color.green
                                .frame(width: 330, height: 55)
                                .cornerRadius(8) //
                                .offset(y:-45)
                        }else if(optionEstado == 3){
                            Color(red: 255/255, green: 0/255, blue: 0/255)
                                .frame(width: 330, height: 55)
                                .cornerRadius(8) //
                                .offset(y:-45)
                        }
                        
                        Picker(selection: $optionEstado, label: Text("Picker"))
                        {
                            Text("No cobrado").tag(1)
                            Text("Cobrado").tag(2)
                            Text("Conflicto").tag(3)
                        }.pickerStyle(.segmented)
                            .frame(width: 305)
                            .background(
                                // Apply a background color to the selected segment
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.white) // Change this color to your desired color
                            )
                            .disabled(!isPickerEnabled)
                            .onChange(of: optionEstado){ value in
                                if(optionEstado == 1){
                                    estadoFinal = "PENDING"
                                } else if (optionEstado == 2){
                                    estadoFinal = "COLLECTED"
                                } else if (optionEstado == 3){
                                    estadoFinal = "CONFLICT"
                                }
                                
                            }
                            .padding(.top, -60)
                            .zIndex(2)
                    }
                    
                    VStack{
                        if optionEstado == 3{
                            // Campo de texto 1: Comentarios por conflicto
                            Text("Comentarios de conflicto:")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 35)
                                .padding(.top, -20)
                                .fontWeight(.regular)
                            TextField("Comentario", text: $comentarioAdicional, axis: .vertical)
                                .onReceive(Just(comentarioAdicional)){ // Limita la cantidad de caracteres
                                    _ in limitText(textLimit)}
                                .onTapGesture {
                                    
                                }
                                .padding(.leading)
                                .padding(.top,10)
                                .padding(.bottom, 10)
                                .frame(width: 323)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 1)
                                ).padding(.bottom, 50)
                            //padding del textfield
                                .padding(.top, -5)
                                .foregroundColor(commentsColor)
                                .disabled(!isCommentEnabled)
                        }
                    }
                    
                    .onAppear() {
                        comentarioAdicional = ticket.collectorComments
                        if (ticket.state == "PENDING"){
                            optionEstado = 1
                        }
                        else if (ticket.state == "COLLECTED"){
                            optionEstado = 2
                            bloquearEdicion()

                        }
                        else if (ticket.state == "CONFLICT"){
                            optionEstado = 3
                            bloquearEdicion()

                        }
                    } .padding(.bottom, 0)
                        .padding(.top, -5)
                    
                    // Botón: Guardar
                    Button(action: {
                        //
                        showingConfirmationAlert = true
                    }) {
                        Text("Guardar")
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(width: 300, height: 40)
                            .foregroundColor(Color.white)
                    }
                    .frame(height: 60)
                    .buttonStyle(.borderedProminent)
                    .tint(Color(red: 0, green: 156/255, blue: 171/255))
                    .padding(.top, -25)
                    .alert(isPresented: $showingConfirmationAlert) {
                        Alert(
                            title: Text("Confirmar"),
                            message: Text("¿Estás seguro de que deseas guardar los cambios?"),
                            primaryButton: .default(Text("Sí")) {
                                hideKeyboard()
                                CambiarComment(id: ticket.id, comment: comentarioAdicional) { msg in
                                    if let msg = msg, msg != "" {
                                        // Manejar el mensaje de error si es necesario
                                    }
                                }
                                CambiarEstado(id: ticket.id, state: estadoFinal) { msg in
                                    if let msg = msg, msg != "" {
                                        // Manejar el mensaje de error si es necesario
                                    }
                                }
                                yaCargo = false
                                bloquearEdicion()
                                dismiss()
                            },
                            secondaryButton: .cancel(Text("Cancelar"))
                        )
                    }
                    Spacer()
                    
                } .padding(.top, -58)  // scroll
            }
        }
    }
    
    func loadCoordinates() {
        
        var s = calleBD + ", \(coloniaBD), \(numeroCasaBD)"
        print (s)
        fetchCoordinates(for: s) { result in
            //DispatchQueue.main.async {
                switch result {
                case .success(let location):
                    coordinates = "Lat: \(location.lat), Lng: \(location.lng)"
                    self.lat = location.lat
                    self.lng = location.lng
                case .failure(let error):
                    coordinates = "Error: \(error.localizedDescription)"
                }
           // }
        }
    }
    

    func limitText(_ upper: Int){
           if comentarioAdicional.count > upper {
               comentarioAdicional = String(comentarioAdicional.prefix(upper))
           }
    }
    
    func bloquearEdicion(){
        if(ticket.state == "COLLECTED" || ticket.state == "CONFLICT"){
            isPickerEnabled = false
            isCommentEnabled = false
            commentsColor = .gray
        }
    }

}

struct Recibos_Previews: PreviewProvider {
    static var previews: some View {
        @State var yaCargo = false
       // @State var tickete : ticket = tickets()[0]
      
        detallesView(yaCargo: $yaCargo, ticket: tickets(forManagerId: 1)[0])   }
}
