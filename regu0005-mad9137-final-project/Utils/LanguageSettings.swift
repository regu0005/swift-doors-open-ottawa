//
//  LanguageSettings.swift
//  regu0005-mad9137-final-project
//
//  Created by Gustavo Reguerin on 2023-12-15.
//

import SwiftUI

class LanguageSettings: ObservableObject {
    @Published var selectedLanguage: String {
        didSet {
            UserDefaults.standard.set(selectedLanguage, forKey: "SelectedLanguage")
        }
    }

    init() {
        self.selectedLanguage = UserDefaults.standard.string(forKey: "SelectedLanguage") ?? "en"
    }
}
