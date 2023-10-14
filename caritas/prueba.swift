//
//  prueba.swift
//  Cáritas
//
//  Created by Alumno on 13/10/23.
//

import SwiftUI

struct prueba: View {
    @State private var coordinates: String = "Cargando..."

    var body: some View {
        VStack {
            Text(coordinates)
        }
        .onAppear(perform: loadCoordinates)
    }

    
    func loadCoordinates() {
        fetchCoordinates(for: "Av. Eugenio Garza Sada 2501, Monterrey, NL, Mexico") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let location):
                    coordinates = "Lat: \(location.lat), Lng: \(location.lng)"
                case .failure(let error):
                    coordinates = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
}

struct prueba_Previews: PreviewProvider {
    static var previews: some View {
        prueba()
    }
}
