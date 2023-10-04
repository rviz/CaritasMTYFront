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
<<<<<<< Updated upstream


=======
    @State private var conteoIntentos : Int = 0
    @State private var idd: String = ""
    @State private var role: String = ""
    
    // Botón
    @State private var isButtonEnabled = false // Estado para controlar la habilitación del botón y el enlace de navegación pepe
    
>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
                        .frame(width: 330)
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(10) // Añade esquinas redondeadas al fondo
                        .onChange(of: option){ value in
                            
                            
                        } .padding(.top, 20)
=======
                    }.frame(width: 200, height: 50).tint(Color(red: 255/255, green: 255/255, blue: 255/255, opacity: 0)) // botón de atras
                        .navigationDestination(isPresented: $isValid){
                            if (self.role == "MANAGER"){
                                mgm_recolectoresView()
                            }
                            else {
                                contentView()
                            }
                        }
                       
>>>>>>> Stashed changes
                    
                    
                    Button("Validar"){
                            self.isValid = self.validate()
                        }
                        .background(
                            NavigationLink(destination: contentView(), isActive: $isValid) {
                                        Text("Validar")
                                }
                        )
                        .buttonStyle(.borderedProminent)
<<<<<<< Updated upstream
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)

                    Text(mensajeError).foregroundColor(.red)

                    }

               
                }}
=======
                        .foregroundColor(.white)
                        .padding(.top, 60)
                        .font(.title3)
                        .fontWeight(.regular)
                    
                    NavigationLink("Pestaña de manager", destination: mgm_recolectoresView())
                        .offset(y:40)
                        .navigationBarBackButtonHidden(true)
                    
                    Text(mensajeError)
                        .foregroundColor(.red)
                        .offset(y:70)

                }.tint(Color(red: 255/255, green: 255/255, blue: 255/255, opacity: 0.2))
            
            }
            
        }.preferredColorScheme(.light)
        .toolbar(.hidden)
    
        
    }
    /*
     InicioSesion(username: "usuario", password: "contraseña") { id, role in
         if let id = id {
             print("Inicio de sesión exitoso, ID: \(id)")
             if let role = role {
                 print("Rol: \(role)")
                 // Aquí puedes usar el valor de 'role' como lo necesites
             }
         } else {
             print("Inicio de sesión fallido")
         }
     */
    
     func validate() -> Bool {
         InicioSesion(username: usuario, password: contraseña) { id, role in
             if let id = id, id != 0 {
                 self.idd = String(id) // Convierte el entero a String si es necesario
                 print(id)
                 if let role = role {
                     self.role = role
                     print("Rol: \(role)")
                 }
                 // Inicio de sesión exitoso y se ha obtenido un ID válido
             } else if (mensajeError != "Intenta en 10 minutos.") {
                 // Inicio de sesión fallido o ID no válido
                 mensajeError = "Usuario y/o contraseña inválidos"
             }
         }
         
         conteoIntentos = conteoIntentos + 1
         print("Conteo actual = " + String(conteoIntentos))
         if(conteoIntentos > 5){
             mensajeError = "Intenta en 10 minutos."
             isButtonEnabled = true
         }
         
         let timer = Timer.scheduledTimer(withTimeInterval: 15, repeats: false) { _ in
             isButtonEnabled.self = false
             conteoIntentos = 0
             mensajeError = " "
         }
         if self.idd == "" {
            return false
>>>>>>> Stashed changes
        }
    private func validate() -> Bool {
        if (usuario != ""){
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
