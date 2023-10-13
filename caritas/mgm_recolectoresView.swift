
// MANAGER

import SwiftUI


struct mgm_recolectoresView: View {
    // Variables
    @State private var option: Int = 1
    @State private var filtroSearch: String = ""
    @State private var searchIsActive = false
    @State private var tipoFiltro: String = ""
    @State private var colorEstado: Color = .black
    @State var yaCargo: Bool = false
    @State var listaR: Array<Collector> = []
    @State var totalTickets: Int = 0

    @State private var dateString: String = "2023-09-27T14:30:00Z" // Sample date string
    @State private var formattedDateString: String = ""
   
    func getAmmountOfCollectedTickets( tickets: Array<ticket>) -> Int {
        var ret: Int = 0;
        for t in tickets {
            if (t.state == "COLLECTED" || t.state == "CONFLICT"){
                ret += 1
            }
        }
        return ret
    }
    
    func isThereConflict( tickets: Array<ticket>) -> Bool {
        for t in tickets {
            if t.state == "CONFLICT" {
                return true
            }
        }
        return false
    }
    
    func countConflicts( tickets: Array<ticket>) -> Int {
        var ret: Int = 0;
        for t in tickets {
            if t.state == "CONFLICT" {
                ret += 1
            }
        }
        return ret
        
    }
   
   
    func getProgressValue(tickets: Array<ticket>) -> Float {
        
    
        let collected: Float = Float(self.getAmmountOfCollectedTickets(tickets: tickets))
        let total: Float = Float(tickets.count)
        if (total == 0) {
            return 0;
        }
        var result = (collected / total)
        
        return result
    }
    
    
    @State private var progressValue: Float = 0.5 // Valor de progreso entre 0 y 1
    
    
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
                        
                        Text("Recolectores")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom, 5)
                            .offset(y:-40)
                            .foregroundColor(Color.white)
                        
                    }.offset(y:40)
                }
                
                HStack{
                    
                    VStack() {
                        /*
                        if(recolectores().isEmpty){
                            Group{
                                Image("notificacionVacio")
                                    .resizable(resizingMode: .stretch)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100)
                                
                                Text("No se encontraron recolectores")
                                    .font(.title3)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 200)

                                
                            }.offset(y:230)
                            */
                        //} else {
                            
                            List (listaR){
                                listaItem in
                                NavigationLink(destination: mgm_listadoView(id:listaItem.id)) {
                                    
                                    HStack{
                                        
                                        var numberConflicts = countConflicts(tickets: listaItem.tickets)
                                        var conflict = isThereConflict(tickets: listaItem.tickets)
                                        
                                        VStack(alignment: .leading, spacing: 5) {
                                            
                                            let progressValue = self.getProgressValue(tickets: listaItem.tickets)
                                            var roundedProgress = Int((progressValue * 100).rounded())
                                            var conflict = isThereConflict(tickets: listaItem.tickets)
                                            
                                            HStack {
                                                // Impresión de etiqueta "sin información"
                                                var recolectorBD: String {
                                                    if listaItem.fullname.isEmpty {
                                                        return "Sin información"
                                                    } else {
                                                        return listaItem.fullname
                                                    }
                                                }
                                                
                                                Text("\(recolectorBD)")
                                                    .fontWeight(.bold)
                                                    .foregroundColor(Color(red: 0, green: 156/255, blue: 171/255))
                                            } .padding(.top, 10)
                                            
                                            
                                            HStack {
                                                
                                                
                                                // Impresión de etiqueta "sin información"
                                                var recolectorBD: String {
                                                    if listaItem.username.isEmpty {
                                                        return "Sin información"
                                                    } else {
                                                        return listaItem.username
                                                    }
                                                }
                                                
                                                Text("Zona:")
                                                    .fontWeight(.bold)
                                                Text(recolectorBD)
                                            }
                                            
                                            
                                            HStack {
                                                // Impresión de etiqueta "sin información"
                                                var recolectorBD: String {
                                                    if listaItem.id == 0 {
                                                        return "Sin información"
                                                    } else {
                                                        return String(listaItem.id)
                                                    }
                                                }
                                                
                                                Text("Recibos finalizados:")
                                                    .fontWeight(.bold)
                                                Text("\(String(self.getAmmountOfCollectedTickets(tickets: listaItem.tickets)))/\(String(listaItem.tickets.count))")
                                                
                                                
                                            }
                                            
                                            
                                            
                                            
                                            HStack{
                                                
                                                // Obtención de porcentaje
                                                let progressValue = self.getProgressValue(tickets: listaItem.tickets)
                                                let roundedProgress = Int((progressValue * 100).rounded())
                                                
                                                // Existencia de conflictos
                                                let conflict = isThereConflict(tickets: listaItem.tickets)
                                                
                                                // Barra de progreso
                                                ProgressView(value: self.getProgressValue(tickets:listaItem.tickets))
                                                    .background(.white) // Establece el fondo del ProgressView en azul
                                                    .progressViewStyle(LinearProgressViewStyle(tint: roundedProgress == 100 && !conflict ? .green : (conflict ? .red : .black)))
                                                
                                                 //Impresión de porcentaje
                                                Text("\(roundedProgress)%")
                                                    .padding(.leading, 10)
                                                    .font(.body)
                                                
                                               
                                            }
                                            .padding(.bottom, 10)
                                            .padding(.top, 12)

                                            
                                            

                                        } .font(.title3)
                                        
                                        ZStack {
                                            Circle()
                                                .fill(conflict ? Color.red : Color.gray)
                                                .frame(width: 30, height: 30)
                                            
                                            Text(String(numberConflicts))
                                                .font(.footnote)
                                                .foregroundColor(.white)
                                                .bold()
                                            
                                        } .offset(x:25, y:-45)
                                          
                                    }
                                    
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
                            .frame(width: 350, height: 700)
                            .padding(.top, 15)
                            .listStyle(.inset)
                            
                        //}
                        
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
