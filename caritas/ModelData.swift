
import Foundation


func callAPILista() -> Array<Recibo> {
    var lista: Array<Recibo> = []
        guard let url = URL(string:"https://jsonplaceholder.typicode.com/posts") else{
            return lista
        }
    
    let group = DispatchGroup()
    group.enter()
    
    let task = URLSession.shared.dataTask(with: url){
        data, response, error in
        let jsonDecoder = JSONDecoder()
        
        if (data != nil){
            do{
                let postList = try jsonDecoder.decode([Recibo].self, from: data!)
                lista = postList
                for postItem in postList {
                    print("Id: \(postItem.id) - Titulo: \(postItem.title) ")
                }
            }catch{
                print(error)
            }
        }
        
        group.leave()
    }
    task.resume()

    group.wait()
    return lista
}

func prueba() -> User? {
    let parameters = """
    {
        "username": "dummy",
        "password": "contrasena"
    }
    """
    
    var user: User?
    
    if let postData = parameters.data(using: .utf8) {
        var request = URLRequest(url: URL(string: "http://10.22.128.249:5000/collector/login")!, timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let group = DispatchGroup()
        group.enter()

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            defer {
                group.leave()
            }
            
            guard let data = data else {
                print(String(describing: error))
                return
            }
            
            do {
                // Decodificar la respuesta JSON en un objeto User
                let decodedUser = try JSONDecoder().decode(User.self, from: data)
                user = decodedUser
            } catch {
                print("Error decoding JSON: \(error)")
            }
            group.leave()
        }

        task.resume()
        
        group.wait()
    } else {
        print("Error encoding parameters")
    }
    
    return user
}

func InicioSesion(completion: @escaping (String?) -> Void) {
    let url = URL(string: "http://10.22.128.249:5000/collector/login")!
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.httpMethod = "POST"
    
    let parameters: [String: Any] = [
        "username": "dummy",
        "password": "contrasena"
    ]
    
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = jsonData
    } catch {
        print("Error al crear el JSON: \(error)")
        completion(nil)
        return
    }
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard
            let data = data,
            let response = response as? HTTPURLResponse,
            error == nil
        else {
            print("error", error ?? URLError(.badServerResponse))
            completion(nil)
            return
        }
        
        guard (200 ... 299) ~= response.statusCode else {
            print("statusCode should be 2xx, but is \(response.statusCode)")
            print("response = \(response)")
            completion(nil)
            return
        }
        
        do {
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let id = jsonObject["id"] as? String {
                completion(id)
            } else {
                print("No se pudo obtener el valor 'id' del JSON.")
                completion(nil)
            }
        } catch {
            print(error) // Error de parsing
            completion(nil)
        }
    }
    task.resume()
}



extension Dictionary {
    func percentEncoded() -> Data? {
        map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed: CharacterSet = .urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
struct ResponseObject<T: Decodable>: Decodable {
    let id: String
}

struct Foo: Decodable {
    let id: String
}

