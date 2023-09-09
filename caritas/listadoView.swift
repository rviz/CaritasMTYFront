
import SwiftUI

struct listadoView: View {
    // Variables
    @State private var option: Int = 1
    @State private var filtroSearch: String = ""
    @State private var tipoFiltro: String = ""
    @State private var lista: Array<ticket> = []
    
    
    var body: some View {
        
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
                        ForEach(Array(lista.enumerated()), id: \.1.id) { index, listaItem in
                            NavigationLink(destination: detallesView()) {
                                Text("\(index + 1). Calle: \(listaItem.id) \n- Colonia: \(listaItem.state) \n-  Hora \(listaItem.date) \n- Monto: \(listaItem.housingReference)")
                            }
                        }
                    }
                    .onAppear() {
                        lista = tickets()
                        
                    }
                    .frame(width: 350, height: 515)
                    .padding(.top, 15)
                    .listStyle(.inset)}

            }
            
            
            Spacer()
            
        }          

        
    }}

struct listadoView_Previews: PreviewProvider {
    static var previews: some View {
        listadoView()
    }
}
