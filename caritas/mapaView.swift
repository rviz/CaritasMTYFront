//
//  mapaView.swift
//  Cáritas
//
//  Created by Alumno on 13/10/23.
//

import SwiftUI
import MapKit
import CoreLocation

struct mapaView: View {
    @State var latitud: Double = 0.0
    @State var longitud: Double = 0.0
    @State var showPosicion: Bool = true
    @State private var region:MKCoordinateRegion = MKCoordinateRegion()
    
    
    //Zoom inicial de 2000 mts
    @State private var latZoom:Double = 2000
    @State private var lonZoom:Double = 2000
    //Variable para mostrar ubicación actual
    @State private var locationManager = CLLocationManager()
        
    var body: some View {
        VStack{
            let customMark: [Marcador] = [Marcador (coordinate: .init(latitude: self.latitud, longitude: self.longitud))]
            Map(coordinateRegion: $region,
               // showsUserLocation: showPosicion,
                showsUserLocation: false,
                userTrackingMode: .constant(.follow),
                annotationItems: customMark,
                annotationContent: { city in
                    MapMarker(coordinate: city.coordinate, tint: .red)
                })
            //MapAnnotation
               .onAppear(){
                   /*
                   if (showPosicion){
                       locationManager.requestWhenInUseAuthorization()
                   }*/
                   region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitud, longitude:longitud), latitudinalMeters: latZoom, longitudinalMeters: lonZoom)
                }
        }.ignoresSafeArea()
    }
}

struct Marcador: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct mapaView_Previews: PreviewProvider {
    static var previews: some View {
        mapaView()
    }
}
