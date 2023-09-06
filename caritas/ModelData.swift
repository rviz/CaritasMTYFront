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

