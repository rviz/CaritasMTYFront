
import Foundation
import UIKit


extension String {
    func removeAccents() -> String {
        return self.folding(options: .diacriticInsensitive, locale: .current)
    }
}


func fetchCoordinates(for address: String, completion: @escaping (Result<Location, Error>) -> Void) {
    // Reemplaza espacios con '+'
    let formattedAddress = address.replacingOccurrences(of: " ", with: "+").removeAccents()
    let apiKey = "AIzaSyA0IhjlpXb-MHMmnQXlBWReFWhBx6wEK6o" // ¡Cambia esto con tu nueva clave API!
    let urlString = "https://maps.googleapis.com/maps/api/geocode/json?address=\(formattedAddress)&key=\(apiKey)"
    
    guard let url = URL(string: urlString) else {
        completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
        return
    }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let data = data else {
            completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(GoogleGeocodeResponse.self, from: data)
            if let firstLocation = response.results.first?.geometry.location {
                completion(.success(firstLocation))
            } else {
                completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "No location found"])))
            }
        } catch let parsingError {
            completion(.failure(parsingError))
        }
    }.resume()
}



let apiLink = "https://equipo04.tc2007b.tec.mx:10203"

func tickets(forManagerId managerId: Int) -> Array<ticket> {
    var lista: Array<ticket> = []
    guard let url = URL(string: "\(apiLink)/ticket/collector-tickets/\(managerId)") else {
        print("Error: URL no válida")
        return lista
    }
    let group = DispatchGroup()
    group.enter()
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        let jsonDecoder = JSONDecoder()
        
        if (data != nil) {
            do {
                let postList = try jsonDecoder.decode(ticketote.self, from: data!)
                lista = postList.tickets
                for postItem in postList.tickets {
                    print("Id: \(postItem.id) - state: \(postItem.state) - housingReference: \(postItem.housingReference) - date: \(postItem.date)")
                }
            } catch {
                print("Error al decodificar JSON: \(error)")
            }
        } else if let error = error {
            print("Error en la solicitud HTTP: \(error)")
        }
        
        group.leave()
    }
    
    task.resume()
    group.wait()
    return lista
}

func recolectores() -> Array<Collector> {
    var lista: Array<Collector> = []
    guard let url = URL(string: "\(apiLink)/collector/get_by_manager_id/1") else {
        print("Error: URL no válida")
        return lista
    }
    
    let group = DispatchGroup() // Crea un DispatchGroup
    group.enter() // Indica que estamos ingresando al grupo
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        let jsonDecoder = JSONDecoder()
        
        if let data = data {
            do {
                let postList = try jsonDecoder.decode(Manager.self, from: data)
                //
                lista = postList.collectors
                //
                for postItem in postList.collectors {
                    print("Id: \(postItem.id) - state: \(postItem.fullname) - housingReference: \(postItem.managerId) - date: \(postItem.uuid)")
                }
                
            } catch {
                print("Error al decodificar JSON: \(error)")
            }
        } else if let error = error {
            print("Error en la solicitud HTTP: \(error)")
        }
        
        group.leave() // Indica que estamos saliendo del grupo después de que se complete la tarea
    }
    
    task.resume()
    group.wait()
    return lista
}

func InicioSesion(username: String, password: String, completion: @escaping (Int?, String?) -> Void) {
    let url = URL(string: "\(apiLink)/general/login")!
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.httpMethod = "POST"
    
    let parameters: [String: Any] = [
        "username": username,
        "password": password
    ]
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = jsonData
    } catch {
        print("Error al crear el JSON: \(error)")
        completion(nil, nil)
        return
    }
    
    let group = DispatchGroup()
    group.enter()
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        defer {
            group.leave()
        }
        
        guard
            let data = data,
            let response = response as? HTTPURLResponse,
            error == nil
        else {
            print("error", error ?? URLError(.badServerResponse))
            completion(nil, nil)            
            return
        }
        
        guard (200 ... 299) ~= response.statusCode else {
            print("statusCode should be 2xx, but is \(response.statusCode)")
            print("response = \(response)")
            completion(nil, nil)            
            return
        }
        
        do {
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let id = jsonObject["id"] as? Int,
                           let role = jsonObject["role"] as? String { // Recuperar el valor del rol del JSON
                            completion(id, role)
            } else {
                print("No se pudo obtener el valor 'id' del JSON.")
                completion(nil, nil)           
            }
        } catch {
            print(error) // Error de parsing
            completion(nil, nil)
        }
    }
    task.resume()
    group.wait()
}



func CambiarComment(id: Int, comment: String, completion: @escaping (String?) -> Void) {
    let url = URL(string: "\(apiLink)/ticket/change_collector_comments")!
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.httpMethod = "POST"
    
    let parameters: [String: Any] = [
        "ticket_id": id,
        "collector_comments": comment
    ]
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = jsonData
    } catch {
        print("Error al crear el JSON: \(error)")
        completion(nil)
        return
    }
    
    let group = DispatchGroup()
    group.enter()
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        defer {
            group.leave()
        }
        
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
               let msg = jsonObject["msg"] as? String {
                print (msg)
                completion(msg)
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
    group.wait()
}


func CambiarEstado(id: Int, state: String, completion: @escaping (String?) -> Void) {
    let url = URL(string: "\(apiLink)/ticket/change_state")!
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.httpMethod = "POST"
    
    let parameters: [String: Any] = [
        "ticket_id": id,
        "new_state": state
    ]
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = jsonData
    } catch {
        print("Error al crear el JSON: \(error)")
        completion(nil)
        return
    }
    
    let group = DispatchGroup()
    group.enter()
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        defer {
            group.leave()
        }
        
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
               let msg = jsonObject["msg"] as? String {
                print (msg)
                completion(msg)
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
    group.wait()
}
