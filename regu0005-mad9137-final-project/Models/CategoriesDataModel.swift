//
//  CategoriesDataModel.swift
//  regu0005-mad9137-final-project
//
//  Created by Gustavo Reguerin on 2023-12-07.
//

import Foundation
import Combine

struct Category: Codable, Identifiable {
    let id: Int
    var category: String
    var image: String?
    var description: String?

    enum CodingKeys: String, CodingKey {
        case id = "id_category", category, image, description
    }
}

class CategoriesDataModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var isLoading = true
    private var selectedLanguage: String
    
    init() {
        self.selectedLanguage = "en"
        fetchCategoriesData()
    }

    private func fetchCategoriesData() {
        let urlString = "https://buildings.tusmodelos.com/api_categories/?lang=\(selectedLanguage)"
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
                let decodedCategories = try JSONDecoder().decode([Category].self, from: data)
                DispatchQueue.main.async {
                    self?.categories = decodedCategories
                    self?.isLoading = false
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func changeLanguage(to newLanguage: String) {
        selectedLanguage = newLanguage
        fetchCategoriesData()
    }
}
