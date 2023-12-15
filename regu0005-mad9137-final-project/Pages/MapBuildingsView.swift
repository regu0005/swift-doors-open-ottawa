//
//  MapBuildingsView.swift
//  regu0005-mad9137-final-project
//
//  Created by Gustavo Reguerin on 2023-12-08.
//

import SwiftUI
import MapKit

struct MapBuildingsView: UIViewRepresentable {
    var buildings: [PostBuilding]
    var userLocation: CLLocationCoordinate2D?

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Center the map if the user location is available
        if let userLocation = userLocation {
            let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
            uiView.setRegion(region, animated: true)
        }

        // Add markers of each building to the map
        let annotations = buildings.compactMap { building -> MKAnnotation? in
            guard let lat = Double(building.latitude ?? ""), let lon = Double(building.longitude ?? "") else { return nil }
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            annotation.title = building.name
            return annotation
        }

        uiView.addAnnotations(annotations)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapBuildingsView

        init(_ parent: MapBuildingsView) {
            self.parent = parent
        }

    }
}

struct MapBuildingsContainerView: View {
    @ObservedObject var buildingsDataModel: BuildingsDataModel

    var body: some View {
        MapBuildingsView(buildings: buildingsDataModel.buildings, userLocation: buildingsDataModel.locationManager.currentLocation)
    }
}


