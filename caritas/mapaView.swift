//
//  mapaView.swift
//  Cáritas
//
//  Created by Alumno on 13/10/23.
//import SwiftUI
import SwiftUI
import MapKit
//import CoreLocation

struct mapaView: View {
    @State var latitud: Double = 0.0
    @State var longitud: Double = 0.0
    
    @State var showPosicion: Bool = true
    @State private var region: MKCoordinateRegion = MKCoordinateRegion()
    @State private var isShowingAlert = true // Mostrar el popup automáticamente al cargar la vista

    // Zoom inicial de 2000 mts
    @State private var latZoom: Double = 2000
    @State private var lonZoom: Double = 2000
    // Variable para mostrar ubicación actual
    @State private var locationManager = CLLocationManager()

    var body: some View {
        VStack {
            let customMark: [Marcador] = [Marcador(coordinate: .init(latitude: self.latitud, longitude: self.longitud))]
            Map(coordinateRegion: $region,
                showsUserLocation: false,
                userTrackingMode: .constant(.follow),
                annotationItems: customMark,
                annotationContent: { city in
                    MapMarker(coordinate: city.coordinate, tint: .red)
                })
                .onAppear {
                    region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitud, longitude: longitud), latitudinalMeters: latZoom, longitudinalMeters: lonZoom)
                }
        }
        .ignoresSafeArea()
        .alert(isPresented: $isShowingAlert) {
            Alert(
                title: Text("Abrir en Mapas"),
                message: Text("¿Deseas abrir esta ubicación en la aplicación Mapas?"),
                primaryButton: .default(Text("Abrir")) {
                    openInMaps()
                },
                secondaryButton: .cancel()
            )
        }
    }

    func openInMaps() {
        let coordinates = CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinates))
        mapItem.name = "Ubicación personalizada"
        mapItem.openInMaps()
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
