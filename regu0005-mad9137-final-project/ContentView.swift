//
//  ContentView.swift
//  regu0005-mad9137-final-project
//
//  Created by Gustavo Reguerin on 2023-12-07.
//
//  Admin System:
//  https://buildings.tusmodelos.com
//  Test user:   testing
//  Password:    testing

import SwiftUI

struct ContentView: View {
    @StateObject var buildingsDataModel = BuildingsDataModel()
    @StateObject var categoriesDataModel = CategoriesDataModel()
    @StateObject var languagesDataModel = LanguagesDataModel()
    
    @EnvironmentObject var networkMonitor: NetworkMonitor
    
    var body: some View {
        NavigationView {
            if(buildingsDataModel.isLoading && 
               categoriesDataModel.isLoading &&
               languagesDataModel.isLoading
            ) {
                ProgressView("Loading...")
                    .font(.headline)
                    .bold()
            }
            else {
                VStack {
                    ScrollView {
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                        
                        HeroSectionView()
                        CategoriesScrollView(categoriesDataModel: categoriesDataModel)
                        RandomBuildingsView()
                        BuildingsByAmenitiesView()
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .navigationBarTitle("Buildings Home", displayMode: .inline)
                .navigationBarHidden(true)
            }
        }
        
    }
}

#Preview {
    ContentView()
}
