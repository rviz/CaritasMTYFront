
// RECOLECTOR

import SwiftUI

struct listadoView: View {
    var id : Int
    // Variables
    @State private var option: Int = 1
    @State private var filtroSearch: String = ""
    @State private var tipoFiltro: String = ""
    @State private var colorEstado: Color = .black
    @State private var lista: Array<ticket> = []
    @State var yaCargo: Bool = false
    
    @State private var formattedDateString: String = ""
    
    // Función para cambiar el formato de una fecha
    private func formatDateString(date: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMMM d, yyyy"
        dateFormatterPrint.locale = Locale(identifier: "es_ES") // Set the locale to Spanish

        if let date = dateFormatterGet.date(from: date) {
            // Capitalize the first letter of the month
            var formattedDate = dateFormatterPrint.string(from: date)
            if let firstChar = formattedDate.first {
                formattedDate.replaceSubrange(formattedDate.startIndex...formattedDate.startIndex, with: String(firstChar).capitalized)
            }
            return formattedDate
        } else {
            return "Fecha inválida"
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                VStack{
                    
                    ZStack{
                        // Barra de color
                        Color(red: 0, green: 156/255, blue: 171/255)
                            .edgesIgnoringSafeArea(.all)
                            .frame(height: 80)
                            .offset(y:-50)
                        
                        Text("Recibos asignados")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom, 5)
                            .offset(y:-40)
                            .foregroundColor(Color.white)
                        
                    }.offset(y:40)
                }
                
                HStack{
                    
                    
                    VStack() {

                        TextField("Buscar por nombre", text: $filtroSearch)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 330)
                            .font(.title3)
                            .fontWeight(.light)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 10)
                        
                        Picker(selection: $option, label: Text("Picker"))
                        {
                            Text("Recibo").tag(1)
                            Text("Nombre").tag(2)
                        }
                        .padding(.top, 3.0)
                        .pickerStyle(.segmented)
                        .frame(width: 330)
                        .onChange(of: option){ value in
                            if(option == 1){
                                tipoFiltro = "Id"
                            } else if (option == 2){
                                tipoFiltro = "Nombre"
                            }
                        }
                        
                        if(tickets(forManagerId:id).isEmpty){
                            Group{
                                Image("notificacionVacio")
                                    .resizable(resizingMode: .stretch)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100)
                                    
                                Text("No se encontraron recibos asignados")
                                    .font(.title3)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                .frame(width: 200)
                                
                            }.offset(y:180)
                            
                            
                        } else {
                            
                            List {
                                ForEach(Array(lista.enumerated()).sorted { (item1, item2) -> Bool in
                                    switch option {
                                        case 1: // Ordenar por colonia
                                            return item1.element.id < item2.element.id
                                        case 2: // Ordenar por nombre de donante
                                            return item1.element.donorName.localizedCaseInsensitiveCompare(item2.element.donorName) == .orderedAscending
                                        default:
                                            return false
                                        }
                                    }, id: \.1.id) { index, listaItem in
                                        if filtroSearch.isEmpty || listaItem.donorName.localizedCaseInsensitiveContains(filtroSearch) {
                                            NavigationLink(destination: detallesView(yaCargo: $yaCargo, ticket: listaItem)) {
                                            VStack(alignment: .leading, spacing: 5) {
                                                
                                                
                                                HStack{
                                                    
                                                    ZStack {
                                                        Circle()
                                                            .fill(Color(red: 0, green: 156/255, blue: 171/255))
                                                            .frame(width: 30, height: 30) // Ajusta el tamaño del círculo según sea necesario
                                                        
                                                        Text("\(index + 1)")
                                                            .font(.footnote)
                                                            .foregroundColor(.white)
                                                            .bold()
                                                        
                                                    } .padding(.leading, -5)
                                                        .padding(.trailing, 15)
                                                    
                                                    
                                                    VStack(alignment: .leading){
                                                        VStack {
                                                            
                                                            // Impresión de etiqueta "sin información"
                                                            var idReciboBD: String {
                                                                if listaItem.id == 0 {
                                                                    return "Sin información"
                                                                } else {
                                                                    return "\(String(listaItem.id))"
                                                                }
                                                            }
                                                            
                                                            Text("Recibo: ")
                                                                .fontWeight(.bold)
                                                            +
                                                            Text("\(idReciboBD)")
                                                            
                                                        }
                                                        
                                                        VStack {
                                                            
                                                            // Impresión de etiqueta "sin información"
                                                            var montoBD: String {
                                                                if listaItem.donationAmount == 0 {
                                                                    return "Sin información"
                                                                } else {
                                                                    return String(listaItem.donationAmount)
                                                                }
                                                            }
                                                            Text("Monto: ")
                                                                .fontWeight(.bold)
                                                            +
                                                            Text("$\(montoBD)")
                                                        }
                                                        
                                                        VStack {
                                                            // Impresión de etiqueta "sin información"
                                                            var donanteBD: String {
                                                                if listaItem.donorName.isEmpty {
                                                                    return "Sin información"
                                                                } else {
                                                                    return listaItem.donorName
                                                                }
                                                            }
                                                            
                                                            Text("Donante: ")
                                                                .fontWeight(.bold)
                                                            +
                                                            Text(donanteBD)
                                                        }
                                                        
                                                        VStack(alignment: .leading){
                                                            if(listaItem.state == "CONFLICT"){
                                                                Text("Conflicto")
                                                                    .padding(.vertical, 3.0)
                                                                    .padding(.horizontal, 11.0)
                                                                    .background(Color.red)
                                                                    .cornerRadius(8)
                                                                
                                                            } else if(listaItem.state == "PENDING"){
                                                                Text("No cobrado")
                                                                    .padding(.vertical, 3.0)
                                                                    .padding(.horizontal, 11.0)
                                                                    .background(.gray)
                                                                    .cornerRadius(8)
                                                                
                                                            } else if (listaItem.state == "COLLECTED"){
                                                                Text("Cobrado")
                                                                    .padding(.vertical, 3.0)
                                                                    .padding(.horizontal, 11.0)
                                                                    .background(.green)
                                                                    .cornerRadius(8)
                                                                
                                                            } else if (listaItem.state.isEmpty){
                                                                Text("Sin información")
                                                            }
                                                        }
                                                        .foregroundColor(.white)
                                                        .font(.title3)
                                                        .offset(y: -5)
                                                        .padding(.bottom, 5)
                                                        
                                                    }.font(.title3)
                                                    
                                                }
                                            }
                                            .padding(0)
                                        }
                                    }
                                }}
                                .refreshable{
                                    lista = tickets(forManagerId:id)
                                }
                                .onAppear() {
                                    if yaCargo==false{
                                        lista = tickets(forManagerId: id)
                                        yaCargo = true
                                    }
                                }
                                .frame(width: 350, height: 515)
                                .padding(.top, 15)
                                .listStyle(.inset)
                            
                        }
                        
                    }
                    
                }
                Spacer()
                
                
            }
            
        }
         
    }
    
    
}



struct listadoView_Previews: PreviewProvider {
    static var previews: some View {
        
        listadoView(id: 1)

    }
}
