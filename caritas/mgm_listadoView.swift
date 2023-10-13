import SwiftUI

struct mgm_listadoView: View {
    var id: Int
    @State private var lista: Array<ticket> = []
    @State var yaCargo: Bool = false
    
    func ticketsWithConflict() -> [ticket] {
        return lista.filter {
            $0.state == "CONFLICT" }

    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    // Barra de color
                    Color(red: 0, green: 156/255, blue: 171/255)
                        .edgesIgnoringSafeArea(.all)
                        .frame(height: 80)
                        .offset(y:-50)
                    
                    Text("Recibos con conflicto")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                        .offset(y:-40)
                        .foregroundColor(Color.white)
                }.offset(y:40)
                
                VStack {
                    if ticketsWithConflict().isEmpty {
                        Spacer()
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
                        Spacer()

                    } else {
                        List {
                            ForEach(Array(lista.enumerated()), id: \.1.id) { _, listaItem in
                                
                                if listaItem.state == "CONFLICT" {
                                    
                                    VStack(alignment: .leading, spacing: 5) {
                                        let idReciboBD = listaItem.id == 0 ? "Sin información" : "\(String(listaItem.id))"
                                        Text("ID: \(idReciboBD)")
                                            .padding(.vertical, 3.0)
                                            .padding(.horizontal, 11.0)
                                            .background(Color(red: 0, green: 156/255, blue: 171/255))
                                            .cornerRadius(8)
                                            .foregroundColor(.white)
                                            .font(.title3)
                                            .padding(.top, 10)
                                        
                                        let donanteBD = listaItem.collectorComments.isEmpty ? "Sin información" : listaItem.collectorComments
                                        Text("Comentarios: ").fontWeight(.bold) + Text(donanteBD)
                                    }
                                    .padding(.bottom, 10)
                                    .font(.title3)
                                }
                            }
                        }
                        .refreshable {
                            lista = tickets(forManagerId: id)
                        }
                        .onAppear {
                            if !yaCargo {
                                yaCargo = true
                            }
                        }
                        .frame(width: 350, height: 515)
                        .padding(.top, 15)
                        .listStyle(.inset)

                    }
                } .onAppear {
                        lista = tickets(forManagerId: id)
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
