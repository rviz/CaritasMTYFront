//
//  ModelData.swift
//  caritas
//
//  Created by Alumno on 05/09/23.
//

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
