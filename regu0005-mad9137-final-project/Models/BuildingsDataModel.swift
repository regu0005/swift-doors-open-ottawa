//
//  BuildingsDataModel.swift
//  regu0005-mad9137-final-project
//
//  Created by Gustavo Reguerin on 2023-12-07.
//
import SwiftUI
import Combine

struct Schedule: Codable {
    var idSchedule: Int
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
        case idSchedule = "id_schedule", monday, tuesday, wednesday, thursday, friday, saturday, sunday, timeIni = "time_ini", timeEnd = "time_end"
    }
}

struct Amenity: Codable {
    var idAmenity: Int
    var amenity: String
    var value: Int
    var icon: String
    var description: String
    var keyword: String
    var comment: String?

    enum CodingKeys: String, CodingKey {
        case idAmenity = "id_amenity", amenity, value, icon, description, keyword, comment
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
    var schedules: [Schedule]?
    var amenities: [Amenity]?

    enum CodingKeys: String, CodingKey {
        case id = "id_building", name, description, buildingYear = "building_year", isNew = "is_new", address, website, email, phoneNumber = "phone_number", cellphoneNumber = "cellphone_number", image, imageDescription = "image_description", latitude, longitude, idCategory = "id_category", category, schedules, amenities
    }
}


class BuildingsDataModel: ObservableObject {
    @Published var buildings: [PostBuilding] = []
    @Published var isLoading = true
    
    init() {
        fetchBuildingsData()
    }

    private func fetchBuildingsData() {
        guard let url = URL(string: "https://buildings.tusmodelos.com/api_buildings") else { return }
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
                let decodedBuildings = try JSONDecoder().decode([PostBuilding].self, from: data)
                DispatchQueue.main.async {
                    self?.buildings = decodedBuildings
                    self?.isLoading = false
                    // print("Buildings: \(String(describing: self?.buildings))")
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                print("Received data: \(String(data: data, encoding: .utf8) ?? "Invalid data")")
            }
        }.resume()
    }
}
