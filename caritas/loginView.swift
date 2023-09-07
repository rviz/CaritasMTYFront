import SwiftUI

struct loginView: View {
    
    @State private var option: Int = 0
    @State private var usuario: String = ""
    @State private var contraseña: String = ""
    @State private var coordinador: Bool = false
    @State private var longitud: Int = 0

    // Variables API
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
                        .padding(.bottom, 90)
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
<<<<<<< Updated upstream
                        
                    // Opciones: Estados
                    Picker(selection: $option, label: Text("Picker"))
                    {
=======
                    
                    
                    Picker(selection: $option, label: Text("Picker")) {
>>>>>>> Stashed changes
                        Text("Recolector").tag(1)
                        Text("Coordinador").tag(2)
                    }
                    .padding(.top, 5.0)
                    .pickerStyle(.segmented)
                    
<<<<<<< Updated upstream
                    if usuario == usuarioCorrecto {
                        NavigationLink(
                        destination: contentView(),
                        label: {
                            Text("Iniciar sesión")
                                .font(.title2)
                                .fontWeight(.bold)
                                .frame(width: 300, height: 50)
                                .foregroundColor(Color.white)
                        })
                        .buttonStyle(.borderedProminent)
                        .tint(Color(hue: 0.543, saturation: 0.272, brightness: 0.931, opacity: 0.3))
                        .padding(.top, 85)
=======
                    .frame(width: 330)
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(10) // Añade esquinas redondeadas al fondo
                    .onChange(of: option){ value in
                        
>>>>>>> Stashed changes
                        
                    } .padding(.top, 20)
                    
                    Button("Iniciar sesión") {
                                    self.isValid = self.validate()
                                }   .buttonStyle(.borderedProminent)
                                    .tint(Color(hue:0.543 , saturation:0.272, brightness:0.931, opacity:0.3))
                                    .frame(width:400, height: 50)
                                    .font(.title)
                                .background(
                                    NavigationLink(destination: contentView(), isActive: $isValid) {
                                    }
                                )
                                
                    
                    Text(mensajeError).foregroundColor(.red)

<<<<<<< Updated upstream
                    } else {
                        Button(action: {
                            showAlert = true
                        }) {
                            Text("Iniciar sesión")
                                .font(.title2)
                                .fontWeight(.bold)
                                .frame(width: 300, height: 50)
                                .foregroundColor(Color.white)
                            }.alert("La contraseña y/o usuario son inválidos. Por favor vuelve a intentarlo.", isPresented: $showAlert) {
                                Button("OK"){}
                                }
                                .buttonStyle(.borderedProminent)
                                .tint(Color(hue: 0.543, saturation: 0.272, brightness: 0.931, opacity: 0.3))
                                .padding(.top, 105)
                                }
                }}
        }
=======
                    }}
>>>>>>> Stashed changes

            }
            
        }
    
    
    
    
    
        private func validate() -> Bool {
            if (usuario == ""){
                return true
            }else{
                mensajeError = "Debe ingresar usuario"
                return false
            }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        loginView()
    }
}
