//
//  OthersView.swift
//  regu0005-mad9137-final-project
//
//  Created by Gustavo Reguerin on 2023-12-15.
//

import SwiftUI

struct OthersView: View {
    @ObservedObject var languagesDataModel : LanguagesDataModel
    @ObservedObject var buildingsDataModel : BuildingsDataModel
    @ObservedObject var amenitiesDataModel : AmenitiesDataModel
    @ObservedObject var categoriesDataModel : CategoriesDataModel
    
    @State private var selectedLanguageId: Int

    init(languagesDataModel: LanguagesDataModel, buildingsDataModel: BuildingsDataModel, amenitiesDataModel: AmenitiesDataModel, categoriesDataModel: CategoriesDataModel) {
        self._languagesDataModel = ObservedObject(initialValue: languagesDataModel)
        self._buildingsDataModel = ObservedObject(initialValue: buildingsDataModel)
        self._amenitiesDataModel = ObservedObject(initialValue: amenitiesDataModel)
        self._categoriesDataModel = ObservedObject(initialValue: categoriesDataModel)

        if let defaultLanguage = languagesDataModel.getDefaultLanguage() {
            self._selectedLanguageId = State(initialValue: defaultLanguage.id)
        } else {
            self._selectedLanguageId = State(initialValue: 0)
        }
    }

    
    var body: some View {
        NavigationView {
                    List {
                        if languagesDataModel.isLoading {
                            ProgressView()
                        } else {
                            Section(header: Text("Language").font(.title3).bold()) {
                                Picker("Select Language", selection: $selectedLanguageId) {
                                    ForEach(languagesDataModel.languages) { language in
                                        Text(language.language).tag(language.id)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .onChange(of: selectedLanguageId) { newValue in
                                        if let selectedLanguage = languagesDataModel.languages.first(where: {$0.id == newValue}) {
                                            buildingsDataModel.changeLanguage(to: selectedLanguage.abbreviation)
                                            amenitiesDataModel.changeLanguage(to: selectedLanguage.abbreviation)
                                            categoriesDataModel.changeLanguage(to: selectedLanguage.abbreviation)
                                        }
                                    }
                            }
                        }
                        
                        Section(header: Text("About section").font(.title3).bold()) {
                            NavigationLink(destination: AboutEventView()) {
                                HStack {
                                    Text("About the Event")
                                        .frame(width: 180)
                                    HStack {
                                        Text("Details")
                                            .foregroundColor(.white)
                                        Spacer()
                                        Image(systemName: "info.circle.fill")
                                            .foregroundColor(.white)
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                }
                            }
                            NavigationLink(destination: InfoView()) {
                                HStack {
                                    Text("About Developer")
                                        .frame(width: 180)
                                    HStack {
                                        Text("Details")
                                            .foregroundColor(.white)
                                        Spacer()
                                        Image(systemName: "info.circle.fill")
                                            .foregroundColor(.white)
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                }
                            }
                        }
                    }
                    .navigationTitle("More options")
        } // end navigationview
        
    }
}
