import SwiftUI

struct loginView: View {
    
    @State private var option: Int = 0
    @State private var usuario: String = ""
    @State private var contraseña: String = ""
    @State private var usuarioCorrecto: String = ""
    @State private var contraseñaCorrecto: String = ""
    @State private var showAlert = false
    
    @State private var isValid = false
    @State private var mensajeError = ""


    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 156/255, blue: 171/255), Color(red: 0/255, green: 59/255, blue: 92/255, opacity: 255.0)]), startPoint: .top, endPoint: .bottomLeading)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("logocaritasBlanco2")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250)
                        .padding(.bottom, 100)
                        .padding(.top, 70)
                    
                    Text("Usuario:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title3)
                        .fontWeight(.regular)
                        .padding([.bottom, .trailing], -3.0)
                        .padding(.leading, 34)
                        .foregroundColor(Color.white)
                    
                    TextField("", text: $usuario)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 330)
                        .font(.title)
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                    
                    
                    Text("Contraseña:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title3)
                        .fontWeight(.regular)
                        .padding([.bottom, .trailing], -3.0)
                        .padding(.leading, 34)
                        .padding(.top, 25)
                        .foregroundColor(Color.white)
                    
                    SecureField("", text: $contraseña)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 330)
                        .font(.title)
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                    
                    
                    Picker(selection: $option, label: Text("Picker")) {
                        Text("Recolector").tag(1)
                        Text("Coordinador").tag(2)
                    }
                    .padding(.top, 5.0)
                    .pickerStyle(.segmented)
                    
                    .frame(width: 330)
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(10) // Añade esquinas redondeadas al fondo
                    .onChange(of: option){ value in
                        
                        
                    } .padding(.top, 20)
                    
                    
                    Button{
                        self.isValid = self.validate()
                    } label: {
                        Text("Iniciar sesión")
                            .frame(width: 327, height: 61)
                            .background(Color(red: 255/255, green: 255/255, blue: 255/255, opacity: 0.0))
                            .cornerRadius(10)
                        
                    }.frame(width: 200, height: 50).tint(Color(red: 255/255, green: 255/255, blue: 255/255, opacity: 0)) // botón de atras
                        .background(
                            NavigationLink(destination: contentView(), isActive: $isValid) {
                                    Text("Iniciar sesión")
                                    .frame(width: 300, height: 50) // botón de adelante
                            }

                        )
                        .buttonStyle(.borderedProminent)
                        .foregroundColor(.white)
                        .padding(.top, 65)
                        .font(.title3)
                        .fontWeight(.regular)
                    
                    Text(mensajeError)
                        .foregroundColor(.red)
                        .padding(.top, 18)

                }.tint(Color(red: 255/255, green: 255/255, blue: 255/255, opacity: 0.2))
                    
                }
            
        }.preferredColorScheme(.light)
        
    }
    
    private func validate() -> Bool {
        if (usuario != ""){
           return true
        }else{
            mensajeError = "Ingresa tu usuario"
            return false
        }
    }

    }



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        loginView()
    }
}
