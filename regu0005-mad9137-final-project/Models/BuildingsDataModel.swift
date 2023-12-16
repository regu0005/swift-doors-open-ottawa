//
//  BuildingsDataModel.swift
//  regu0005-mad9137-final-project
//
//  Created by Gustavo Reguerin on 2023-12-07.
//
import SwiftUI
import Combine
import CoreLocation

struct Schedule: Codable {
    var id: Int
    var monday: Int
    var tuesday: Int
    var wednesday: Int
    var thursday: Int
    var friday: Int
    var saturday: Int
    var sunday: Int
    var timeIni: String
    var timeEnd: String

    enum CodingKeys: String, CodingKey {
        case id = "id_schedule", monday, tuesday, wednesday, thursday, friday, saturday, sunday, timeIni = "time_ini", timeEnd = "time_end"
    }
}

struct Amenity: Codable {
    let id: Int
    var amenity: String
    var value: Int
    var icon: String?
    var description: String?
    var keyword: String
    var comment: String?

    enum CodingKeys: String, CodingKey {
        case id = "id_amenity", amenity, value, icon, description, keyword, comment
    }
}

struct PostBuilding: Codable, Identifiable {
    let id: Int
    var name: String
    var description: String?
    var buildingYear: String?
    var isNew: Int
    var address: String
    var website: String
    var email: String?
    var phoneNumber: String?
    var cellphoneNumber: String?
    var image: String?
    var imageDescription: String?
    var latitude: String?
    var longitude: String?
    var idCategory: Int
    var category: String
    var visits: Int
    var distance: CLLocationDistance?
    var schedules: [Schedule]?
    var amenities: [Amenity]?

    enum CodingKeys: String, CodingKey {
        case id = "id_building", name, description, buildingYear = "building_year", isNew = "is_new", address, website, email, phoneNumber = "phone_number", cellphoneNumber = "cellphone_number", image, imageDescription = "image_description", latitude, longitude, idCategory = "id_category", category, visits, schedules, amenities
    }
}


class BuildingsDataModel: ObservableObject {
    @Published var buildings: [PostBuilding] = []
    @Published var isLoading = true
    @Published var filteredBuildingsCount: Int = 0 
    @Published var randomBuildings: [PostBuilding] = []
    
    var locationManager = LocationManager()
    
    private var selectedLanguage: String
    
    init() {
        self.selectedLanguage = "en"
        locationManager.startUpdatingLocation()
        fetchBuildingsData()
    }
    
    private func calculateDistance(for building: inout PostBuilding) {
    
            guard let userLocation = locationManager.currentLocation,
                  let buildingLat = Double(building.latitude ?? ""),
                  let buildingLon = Double(building.longitude ?? "") else {
                building.distance = nil
                return
            }
    
            let buildingLocation = CLLocation(latitude: buildingLat, longitude: buildingLon)
            let userCLLocation = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
            let distanceInMeters = userCLLocation.distance(from: buildingLocation)

            // Convert meters to kilometers and round to two decimal places
            let distanceInKilometers = (distanceInMeters / 1000).rounded(toPlaces: 2)
            building.distance = distanceInKilometers
    }
        
    private func fetchBuildingsData() {
        let urlString = "https://buildings.tusmodelos.com/api_buildings/?lang=\(selectedLanguage)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("No data received.")
                return
            }
            do {
                var decodedBuildings = try JSONDecoder().decode([PostBuilding].self, from: data)
                decodedBuildings = decodedBuildings.map { var building = $0
                                                self?.calculateDistance(for: &building)
                                                return building
                                            }
                DispatchQueue.main.async {
                    self?.buildings = decodedBuildings
                    self?.isLoading = false
                    // print("Buildings: \(String(describing: self?.buildings))")
                    self?.updateRandomBuildings()
                    
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                print("Received data: \(String(data: data, encoding: .utf8) ?? "Invalid data")")
            }
        }.resume()
    }
    
    func updateRandomBuildings() {
            self.randomBuildings = Array(buildings.shuffled().prefix(5))
    }
    
    func getTopThreeVisitedBuildings(count: Int = 3) -> [PostBuilding] {
            return Array(buildings.sorted { $0.visits > $1.visits }.prefix(count))
    }
   
    func filterBuildings(selectedAmenities: Set<Int>, searchText: String) -> [PostBuilding] {
        
        if selectedAmenities.isEmpty && searchText.isEmpty {
                return []
            }
        
        return buildings.filter { building in
            let nameMatch = searchText.isEmpty || building.name.lowercased().contains(searchText.lowercased())

            if selectedAmenities.isEmpty {
                return nameMatch
            }

            let amenitiesMatch = building.amenities?.contains(where: { amenity in
                selectedAmenities.contains(amenity.id)
            }) ?? false

            return nameMatch && amenitiesMatch
        }
    }
    
    func sortBuildingsByDistance() {
        self.buildings.sort { ($0.distance ?? Double.infinity) < ($1.distance ?? Double.infinity) }
    }
    
    func changeLanguage(to newLanguage: String) {
            selectedLanguage = newLanguage
            fetchBuildingsData() 
    }
    
    func filterBuildingsByCategory(idCategory: Int) -> [PostBuilding] {
            return buildings.filter { $0.idCategory == idCategory }
    }
}

extension Double {
    // Rounds the double to 'places' decimal places.
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
