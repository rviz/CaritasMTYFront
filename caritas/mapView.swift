//
//  mapView.swift
//  caritas
//
//  Created by Alumno on 04/10/23.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @State var latitud: Double = 0.0
    @State var longitud: Double = 0.0
    @State var customMark: [Marcador] = [Marcador (coordinate: .init(latitude: 25.649991, longitude: -100.29))]
    @State var showPosicion: Bool = true
    @State private var region:MKCoordinateRegion = MKCoordinateRegion()
    
    
    //Zoom inicial de 2000 mts
    @State private var latZoom:Double = 2000
    @State private var lonZoom:Double = 2000
    //Variable para mostrar ubicación actual
    @State private var locationManager = CLLocationManager()
        
    var body: some View {
        VStack{
            Map(coordinateRegion: $region,
                showsUserLocation: showPosicion,
                userTrackingMode: .constant(.follow),
                annotationItems: customMark,
                annotationContent: { city in
                    MapMarker(coordinate: city.coordinate, tint: .red)
                })
            //MapAnnotation
               .onAppear(){
                   if (showPosicion){
                       locationManager.requestWhenInUseAuthorization()
                   }
                   region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitud, longitude:longitud), latitudinalMeters: latZoom, longitudinalMeters: lonZoom)
                }
        }.ignoresSafeArea()
    }
}

struct Marcador: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
