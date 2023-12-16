//
//  AmenitiesDataModel.swift
//  regu0005-mad9137-final-project
//
//  Created by Gustavo Reguerin on 2023-12-09.
//

import Foundation
import Combine

struct PostAmenity: Codable, Identifiable {
    let id: Int
    var amenity: String
    var icon: String?
    var active: Int
    var description: String?
    var keyword: String?

    enum CodingKeys: String, CodingKey {
        case id = "id_amenity", amenity, icon, active, description, keyword
    }
}

class AmenitiesDataModel: ObservableObject {
    @Published var amenities: [PostAmenity] = []
    @Published var isLoading = true

    @Published var selectedAmenities: Set<Int> = []
    
    private var selectedLanguage: String
    
    init() {
        self.selectedLanguage = "en"
        fetchAmenitiesData()
    }

    private func fetchAmenitiesData() {
        let urlString = "https://buildings.tusmodelos.com/api_amenities/?lang=\(selectedLanguage)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("No data received.")
                return
            }
            do {
                let decodedAmenities = try JSONDecoder().decode([PostAmenity].self, from: data)
                DispatchQueue.main.async {
                    self?.amenities = decodedAmenities
                    // Init selectedAmenities ...
                    if self?.selectedAmenities.isEmpty == true {
                        self?.selectedAmenities = Set(decodedAmenities.map { $0.id })
                    }
                    self?.isLoading = false
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func changeLanguage(to newLanguage: String) {
        selectedLanguage = newLanguage
        fetchAmenitiesData()
    }
}
