
// RECOLECTOR

import SwiftUI

struct mgm_listadoView: View {
    var id : Int
    // Variables
    @State private var option: Int = 1
    @State private var filtroSearch: String = ""
    @State private var tipoFiltro: String = ""
    @State private var colorEstado: Color = .black
    @State private var lista: Array<ticket> = []
    @State var yaCargo: Bool = false
    @State private var formattedDateString: String = ""
    var displayedItemsCount: Int = 1
    @State private var contadorConflictos: Int = 0
    
    func isThereConflict( tickets: Array<ticket>) -> Bool {
        var ret: Int = 0;
        for t in tickets {
            if t.state == "CONFLICT" {
                ret += 1
            }
        }
        
        if(ret != 0){
            return true
        } else {
            return false
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
                        
                        Text("Tickets con conflicto")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom, 5)
                            .offset(y:-40)
                            .foregroundColor(Color.white)

                    }.offset(y:40)
                }
                
                HStack{

                    
                    VStack() {
                        
                    
                        if (contadorConflictos != 5){

                            Group{
                                Image(systemName: "face.smiling.inverse")
                                    .resizable(resizingMode: .stretch)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100)
                                    .foregroundColor(Color(red: 0, green: 156/255, blue: 171/255))
                                    .padding(.bottom, 20)

                                Text("Este recolector no tiene recibos con conflicto.")
                                    .font(.title3)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 250)

                            }.offset(y:230)
                        }
                        else{
                            
                            List {
                                
                                ForEach(Array(lista.enumerated()), id: \.1.id) { index, listaItem in
                                    // Validación: Sólo se despliegan recibos en estado "conflict"
                                    
                                    if listaItem.state == "CONFLICT" {
                                        
                                        
                                        VStack(alignment: .leading, spacing: 5) {
                                            
                                            
                                            
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
                                                    
                                                    
                                                    Text("ID: \(idReciboBD)")
                                                        .padding(.vertical, 3.0)
                                                        .padding(.horizontal, 11.0)
                                                        .background(Color(red: 0, green: 156/255, blue: 171/255))
                                                        .cornerRadius(8)
                                                        .foregroundColor(.white)
                                                        .font(.title3)
                                                    
                                                }.padding(.top, 10)
                                                
                                                
                                                
                                                VStack {
                                                    // Impresión de etiqueta "sin información"
                                                    var donanteBD: String {
                                                        if listaItem.collectorComments.isEmpty {
                                                            return "Sin información"
                                                        } else {
                                                            return listaItem.collectorComments
                                                        }
                                                    }
                                                    
                                                    Text("Comentarios: ")
                                                        .fontWeight(.bold)
                                                    +
                                                    Text(donanteBD)
                                                }.padding(.bottom, 10)
                                                
                                            }.font(.title3)
                                            
                                        }
                                        
                                        .padding(0)
                                    }
                                }
                            }
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





struct mgm_listadoView_Previews: PreviewProvider {
    static var previews: some View {
        
        mgm_listadoView(id: 1)

    }
}

