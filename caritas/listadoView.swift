
import SwiftUI

struct listadoView: View {
    // Variables
    @State private var option: Int = 1
    @State private var filtroSearch: String = ""
    @State private var tipoFiltro: String = ""
    @State private var colorEstado: Color = .black
    @State private var lista: Array<ticket> = []
    @State var yaCargo: Bool = false
    
    
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
                        
                        Text("Tickets asignados")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom, 5)
                            .offset(y:-40)
                            .foregroundColor(Color.white)
                        
                    }.offset(y:40)
                }
                
                HStack{
                    
                    
                    VStack() {
                        
                        
                        
                        TextField("Buscar por ID", text: $filtroSearch)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 330)
                            .font(.title3)
                            .fontWeight(.light)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 10)
                        
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
                    
                        List {
                            ForEach(Array(lista.enumerated()), id: \.1.id){
                                index, listaItem in
                                NavigationLink(destination: detallesView(ticket:listaItem)) {
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
                                //yaCargo = true
                            }
                        }
                        .frame(width: 350, height: 515)
                        .padding(.top, 15)
                        .listStyle(.inset)
                        
                    }
                    
                }
                Spacer()
            }
        }
        
    }
}
struct listadoView_Previews: PreviewProvider {
    static var previews: some View {
        
        listadoView()
    }
}
