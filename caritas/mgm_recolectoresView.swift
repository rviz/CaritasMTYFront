
// MANAGER

import SwiftUI


struct mgm_recolectoresView: View {
    // Variables
    @State private var option: Int = 1
    @State private var filtroSearch: String = ""
    @State private var searchIsActive = false
    @State private var tipoFiltro: String = ""
    @State private var colorEstado: Color = .black
    @State private var lista: Array<ticket> = []
    @State var yaCargo: Bool = false
    
    
    var body: some View {
        NavigationStack {
            VStack{
                List {
                    ForEach(Array(lista.enumerated()), id: \.1.id){
                        index, listaItem in
                        NavigationLink(destination: detallesView(yaCargo:$yaCargo,ticket:listaItem)) {
                            VStack(alignment: .leading, spacing: 5) {
                                
                                HStack {
                                    // Impresión de etiqueta "sin información"
                                    var idReciboBD: String {
                                        if listaItem.id == 0 {
                                            return "Sin información"
                                        } else {
                                            return "#\(String(listaItem.id))"
                                        }
                                    }
                                    
                                    Text("Recibo \(index + 1):")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 0, green: 156/255, blue: 171/255))
                                    Text("\(idReciboBD)")
                                }
                                
                                HStack {
                                    // Impresión de etiqueta "sin información"
                                    var calleBD: String {
                                        if listaItem.housingReference.isEmpty {
                                            return "Sin información"
                                        } else {
                                            return listaItem.housingReference
                                        }
                                    }
                                    
                                    Text("- Calle:")
                                        .fontWeight(.bold)
                                    Text(calleBD)
                                }
                                
                                
                                HStack{
                                    Text("- Estado:")
                                        .bold()
                                    if(listaItem.state == "CONFLICT"){
                                        Text("Conflicto")
                                            .foregroundColor(.red)
                                            .bold()
                                    } else if(listaItem.state == "PENDING"){
                                        Text("No cobrado")
                                            .foregroundColor(.black)
                                    } else if (listaItem.state == "COLLECTED"){
                                        Text("Cobrado")
                                            .foregroundColor(.green)
                                            .bold()
                                    } else if (listaItem.state.isEmpty){
                                        Text("Sin información")
                                    }
                                    
                                }
                                
                                HStack {
                                    // Impresión de etiqueta "sin información"
                                    var fechaBD: String {
                                        if listaItem.date.isEmpty {
                                            return "Sin información"
                                        } else {
                                            return listaItem.date
                                        }
                                    }
                                    
                                    Text("- Fecha:")
                                        .fontWeight(.bold)
                                    Text(fechaBD)
                                }
                                
                                HStack {
                                    
                                    // Impresión de etiqueta "sin información"
                                    var montoBD: String {
                                        if listaItem.donationAmount == 0 {
                                            return "Sin información"
                                        } else {
                                            return String(listaItem.donationAmount)
                                        }
                                    }
                                    
                                    Text("- Monto:")
                                        .fontWeight(.bold)
                                    Text("$\(montoBD)")
                                }
                            }
                            .padding(0)
                        }
                    }
                }
                .refreshable{
                    lista = tickets()
                }
                .onAppear() {
                    if yaCargo==false{
                        lista = tickets()
                        yaCargo = true
                    }
                }
                .frame(width: 350)
                .listStyle(.inset)
                .navigationTitle("Recolectores")
            }
            .searchable(text: $filtroSearch, prompt: "Busca un recolector")
        }
    }
}
struct mgm_recolectoresView_Previews: PreviewProvider {

    static var previews: some View {
        mgm_recolectoresView()
    }
}

