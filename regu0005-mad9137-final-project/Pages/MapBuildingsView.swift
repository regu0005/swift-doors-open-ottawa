//
//  MapBuildingsView.swift
//  regu0005-mad9137-final-project
//
//  Created by Gustavo Reguerin on 2023-12-08.
//

import SwiftUI
import MapKit

func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data, let image = UIImage(data: data) {
            completion(image)
        } else {
            completion(nil)
        }
    }.resume()
}

class BuildingAnnotation: MKPointAnnotation {

    var building: PostBuilding?
    
    var imageName: String? {
       return building?.image
    }

    var categoryName: String? {
       return building?.category
    }
}

struct MapBuildingsView: UIViewRepresentable {
    var buildings: [PostBuilding]
    var userLocation: CLLocationCoordinate2D?
    var onBuildingTapped: (PostBuilding) -> Void

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
        
        let annotations = buildings.compactMap { building -> MKAnnotation? in
            guard let lat = Double(building.latitude ?? ""), let lon = Double(building.longitude ?? "") else { return nil }
            let annotation = BuildingAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            annotation.title = building.name
            annotation.building = building
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
        
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let buildingAnnotation = annotation as? BuildingAnnotation else { return nil }


            let identifier = "Building"
            var view: MKMarkerAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)

                let detailLabel = UILabel()
                detailLabel.numberOfLines = 0
                detailLabel.font = detailLabel.font.withSize(12)
                detailLabel.text = buildingAnnotation.categoryName
                view.detailCalloutAccessoryView = detailLabel

                if let imageName = buildingAnnotation.imageName, let imageURL = URL(string: imageName) {
                                    loadImage(from: imageURL) { image in
                                        DispatchQueue.main.async {
                                            let imageView = UIImageView(image: image)
                                            imageView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
                                            view.leftCalloutAccessoryView = imageView
                                        }
                                    }
                                }

                let button = UIButton(type: .detailDisclosure)
                view.rightCalloutAccessoryView = button
            }

            return view
        }

            func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
                    if let buildingAnnotation = view.annotation as? BuildingAnnotation,
                       let building = buildingAnnotation.building {
                        parent.onBuildingTapped(building)
                    }
            }
    }
}


struct MapBuildingsContainerView: View {
    @ObservedObject var buildingsDataModel: BuildingsDataModel
    @ObservedObject var amenitiesDataModel : AmenitiesDataModel
    @ObservedObject var favoritesManagerModel: FavoritesManagerModel
    @State private var selectedBuilding: PostBuilding?

    var networkMonitor: NetworkMonitorService

    @State private var isNavigationActive = false

    var body: some View {
        NavigationView {

            MapBuildingsView(
                    buildings: buildingsDataModel.buildings,
                    userLocation: buildingsDataModel.locationManager.currentLocation,
                    onBuildingTapped: { building in
                        self.selectedBuilding = building // Update the selected building
                        self.isNavigationActive = true
                    }
                )
                .background(
                    Group {
                        if let selectedBuilding = selectedBuilding {
                            // Show the detail view only if a building is selected
                            NavigationLink(destination: BuildingDetailView(
                                buildingsDataModel: buildingsDataModel,
                                amenitiesDataModel: amenitiesDataModel,
                                favoritesManagerModel: favoritesManagerModel,
                                networkMonitor: networkMonitor,
                                building: selectedBuilding,
                                onDisappear: {
                                            // Reset the state when the BuildingDetailView disappears
                                            self.selectedBuilding = nil
                                            self.isNavigationActive = false
                                        }
                            ), isActive: .constant(true)) {
                                EmptyView()
                            }
                            .hidden()
                        }
                    }
                )
        }
    }
}




