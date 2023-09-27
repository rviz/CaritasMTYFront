
// MANAGER

import SwiftUI

/*
struct mgm_recolectoresView: View {
    // Variables
    @State private var option: Int = 1
    @State private var filtroSearch: String = ""
    @State private var searchIsActive = false
    @State private var tipoFiltro: String = ""
    @State private var colorEstado: Color = .black
    @State private var lista: Array<ticket> = []
    @State var yaCargo: Bool = false
    // Agregar un array con los nombres cuando tenga endpoint de la lista de recolectores por manager id.
    // Integrar ese array en el ForEach de la linea 23.
    
    var body: some View {
                
                NavigationStack {
                    List {
                        ForEach(Array(lista.enumerated()), id: \.1.id){
                            index, listaItem in
                            NavigationLink(destination: detallesView(ticket: listaItem)) {
                                VStack(alignment: .leading, spacing: 5) {
                                    
                                    HStack {
                                        Text("Recibo \(index + 1):")
                                            .fontWeight(.bold)
                                            .foregroundColor(Color(red: 0, green: 156/255, blue: 171/255))
                                        Text("#\(listaItem.id)548493")
                                    }
                                    
                                    HStack {
                                        Text("- Calle:")
                                            .fontWeight(.bold)
                                        Text("\(listaItem.housingReference)")
                                    }
                                    
                                    if(listaItem.state == "CONFLICT"){
                                        HStack{
                                            Text("- Estado: ")
                                                .bold()
                                            Text("\(listaItem.state)")
                                                .foregroundColor(.red)
                                        }
                                        
                                    } else if (listaItem.state == "PENDING"){
                                        HStack{
                                            Text("- Estado: ")
                                                .bold()
                                            Text("\(listaItem.state)")
                                                .foregroundColor(.gray)
                                        }
                                    } else if (listaItem.state == "COLLECTED"){
                                        HStack{
                                            Text("- Estado: ")
                                                .bold()
                                            Text("\(listaItem.state)")
                                                .foregroundColor(.green)
                                        }
                                    }
                                    
                                    HStack {
                                        Text("- Fecha:")
                                            .fontWeight(.bold)
                                        Text("\(listaItem.date)")
                                    }
                                    
                                    HStack {
                                        Text("- Monto:")
                                            .fontWeight(.bold)
                                        Text("$\(listaItem.donationAmount)")
                                    }
                                }
                                .padding(0)
                            }
                        }
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
                }.searchable(text: $filtroSearch, prompt: "Busca un recolector")

        }
}
struct mgm_recolectoresView_Previews: PreviewProvider {
    static var previews: some View {
        mgm_recolectoresView()
    }
}
*/
