import SwiftUI

struct loginView: View {
    
    @State private var option: Int = 0
    @State private var usuario: String = ""
    @State private var contraseña: String = ""
    @State private var isValid = false
    @State private var mensajeError = ""
    @State private var conteoIntentos : Int = 0
    @State private var idd: Int = 0
    @State private var role: String = ""
    @State private var isButtonDisabled = false // Estado para controlar la habilitación del botón y el enlace de navegación pepe
    
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
                        .padding(.bottom, 50)
                        .offset(y:-20)
                    
                    Text("Usuario:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title3)
                        .fontWeight(.regular)
                        .padding([.bottom, .trailing], -3.0)
                        .padding(.leading, 32)
                        .foregroundColor(Color.white)
                    
                    TextField("", text: $usuario)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 330)
                        .font(.title)
                        .fontWeight(.light)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    
                    
                    Text("Contraseña:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title3)
                        .fontWeight(.regular)
                        .padding([.bottom, .trailing], -3.0)
                        .padding(.leading, 32)
                        .padding(.top, 25)
                        .foregroundColor(Color.white)
                    
                    SecureField("", text: $contraseña)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 330)
                        .font(.title)
                        .fontWeight(.light)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    
                    Button{
                        self.isValid = self.validate()
                        hideKeyboard()
                    } label: {
                        Text("Iniciar sesión")
                            .frame(width: 327, height: 61)
                            .background(Color(red: 255/255, green: 255/255, blue: 255/255, opacity: 0.2))
                            .cornerRadius(10)
                    }
                    .frame(height: 50).tint(Color(red: 255/255, green: 255/255, blue: 255/255, opacity: 0)) // botón de atras
                        .navigationDestination(isPresented: $isValid){
                            contentView(id: idd, rol: role)
                        }
                        .buttonStyle(.borderedProminent)
                        .foregroundColor(.white)
                        .padding(.top, 60)
                        .font(.title3)
                        .fontWeight(.regular)
                    Text(mensajeError)
                        .foregroundColor(.red)
                        .offset(y:70)

                }.tint(Color(red: 255/255, green: 255/255, blue: 255/255, opacity: 0.2))
                    .onAppear(){
                        usuario = ""
                        contraseña = ""
                        idd=0
                    }
                    .disabled(isButtonDisabled)
            }
            
        }.preferredColorScheme(.light)
        .toolbar(.hidden)
    }
    
    
     func validate() -> Bool {
         InicioSesion(username: usuario, password: contraseña) { id, role in
             if let id = id, id != 0 {
                 self.idd = id // Convierte el entero a String si es necesario
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
             isButtonDisabled = true
         }
         
         let timer = Timer.scheduledTimer(withTimeInterval: 600, repeats: false) { _ in
             isButtonDisabled.self = false
             conteoIntentos = 0
             mensajeError = " "
         }
         if self.idd == 0 {
            return false
        }
        else {
            return true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        loginView()
    }
}
