
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
        let result = (collected / total)
        
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
                        if(recolectores().isEmpty){
                            Group{
                                Spacer()
                                Image("notificacionVacio")
                                    .resizable(resizingMode: .stretch)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100)
                                Text("No se encontraron recolectores")
                                    .font(.title3)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 200)
                                Spacer()
                            }
                            
                        } else {
                            List (listaR){
                                listaItem in
                                NavigationLink(destination: mgm_listadoView(id:listaItem.id)) {
                                    HStack{
                                        let progressValue = self.getProgressValue(tickets: listaItem.tickets)
                                        let numberConflicts = countConflicts(tickets: listaItem.tickets)
                                        let conflict = isThereConflict(tickets: listaItem.tickets)
                                        let roundedProgress = Int((progressValue * 100).rounded())
                                        
                                        VStack(alignment: .leading, spacing: 5) {
                                            
                                            let progressValue = self.getProgressValue(tickets: listaItem.tickets)
                                            let roundedProgress = Int((progressValue * 100).rounded())
                                            let conflict = isThereConflict(tickets: listaItem.tickets)
                                            
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
                                                // quiero agregar aqui un simbolo de warning
                                            } .padding(.top, 10)
                                            
                                            
                                            HStack {
                                                // Impresión de etiqueta "sin información"
                                                var zonaBD: String {
                                                    if listaItem.username.isEmpty {
                                                        return "Sin información"
                                                    } else {
                                                        return listaItem.username
                                                    }
                                                }
                                                
                                                Text("Zona:")
                                                    .fontWeight(.bold)
                                                Text(zonaBD)
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
                                            }.padding(.bottom,-10)
                                            
                                            if(conflict){
                                                HStack{
                                                    Text("Conflictos:")
                                                        .fontWeight(.bold)
                                                    Text("\(numberConflicts)")
                                                        .font(.callout)
                                                        .padding(.vertical, 1.0)
                                                        .padding(.horizontal, 6.0)
                                                        .foregroundColor(Color.white)
                                                        .background(Color.red)
                                                        .cornerRadius(3)
                                                    
                                                }
                                                .offset(y:10)
                                            }
                                            
                                            HStack{
                                                
                                                // Obtención de porcentaje
                                                let progressValue = self.getProgressValue(tickets: listaItem.tickets)
                                                let roundedProgress = Int((progressValue * 100).rounded())
                                                
                                                // Existencia de conflictos
                                                let conflict = isThereConflict(tickets: listaItem.tickets)
                                                
                                                // Barra de progreso
                                                ProgressView(value: self.getProgressValue(tickets:listaItem.tickets))
                                                    .frame(width: 240)
                                                    .scaleEffect(y: 2.5)
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
                                            .padding(.leading,20)
                                        
                                        
                                          
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
                            .frame(width: 400, height: 630)
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



struct mgm_recolectoresView_Previews: PreviewProvider {
    static var previews: some View {
        
        mgm_recolectoresView()
    }
}
