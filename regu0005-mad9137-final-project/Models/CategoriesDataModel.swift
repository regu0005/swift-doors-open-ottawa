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

    init() {
        fetchCategoriesData()
    }

    private func fetchCategoriesData() {
        guard let url = URL(string: "https://buildings.tusmodelos.com/api_categories") else { return }
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
                    
                    print("Categories: \(String(describing: self?.categories))")
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}
