
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
    @State var listaR: Array<Collector> = []

    
    @State private var dateString: String = "2023-09-27T14:30:00Z" // Sample date string
    @State private var formattedDateString: String = ""
    
    // Función para cambiar el formato de una fecha
    
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
                       
                        List (listaR){
                            listaItem in
                            NavigationLink(destination: mgm_detallesView(yaCargo:$yaCargo, collector:listaItem)) {
                                Text(listaItem.fullname)
                            }
                        }
                        .refreshable{
                            listaR = recolectores()
                        }
                        .onAppear() {
                            if yaCargo==false{
                                listaR = recolectores()
                                yaCargo = true
                            }
                        }
                    
                    }
                    
                }
                Spacer()
                
                
            }
            
        }
         
    }
    
    
}



struct mgm_recolectoresView_Previews: PreviewProvider {
    static var previews: some View {
        
        mgm_recolectoresView()
    }
}
