//
//  LanguagesDataModel.swift
//  regu0005-mad9137-final-project
//
//  Created by Gustavo Reguerin on 2023-12-07.
//

import Foundation
import Combine

struct Language: Codable, Identifiable {
    let id: Int
    var language: String
    var abbreviation: String

    enum CodingKeys: String, CodingKey {
        case id = "id_language", language, abbreviation = "abreviation"
    }
}

class LanguagesDataModel: ObservableObject {
    @Published var languages: [Language] = []
    @Published var isLoading = true
    @Published var selectedLanguage: String

    init() {
        self.selectedLanguage = UserDefaults.standard.string(forKey: "SelectedLanguage") ?? "en" // "en" default language
        fetchLanguagesData()
    }

    private func fetchLanguagesData() {
        guard let url = URL(string: "https://buildings.tusmodelos.com/api_languages") else { return }
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
                let decodedLanguages = try JSONDecoder().decode([Language].self, from: data)
                DispatchQueue.main.async {
                    self?.languages = decodedLanguages
                    self?.isLoading = false
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func getDefaultLanguage() -> Language? {
        return languages.first
    }
    
    func setSelectedLanguage(_ abbreviation: String) {
        if let language = languages.first(where: {$0.abbreviation == abbreviation}) {
            selectedLanguage = language.abbreviation
            UserDefaults.standard.set(language.abbreviation, forKey: "SelectedLanguage")
            print("Current Language: \(selectedLanguage)")
        }
    }
}
