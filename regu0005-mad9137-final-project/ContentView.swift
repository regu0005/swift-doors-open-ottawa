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
    @StateObject var amenitiesDataModel = AmenitiesDataModel()
    @StateObject var languagesDataModel = LanguagesDataModel()
    @StateObject var favoritesManagerModel = FavoritesManagerModel()
        
    @EnvironmentObject var networkMonitor: NetworkMonitor
//    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        
                TabView {
                    NavigationView {
                        VStack {
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
                                        HeroSectionView(buildingsDataModel:buildingsDataModel)
                                        CategoriesScrollView(categoriesDataModel: categoriesDataModel)
                                        
                                        //NavigationView {
                                        RandomBuildingsView(buildingsDataModel: buildingsDataModel, amenitiesDataModel: amenitiesDataModel, favoritesManagerModel: favoritesManagerModel, networkMonitor: networkMonitor)
                                        //}
                                        BuildingsByAmenitiesView()
                                    }
                                }
                                .edgesIgnoringSafeArea(.all)
                                .navigationBarTitle("Buildings Home", displayMode: .inline)
                                .navigationBarHidden(true)
                            }
                        }
                    }
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    // Search Tab
                    NavigationView {
                        SearchBuildingsView(buildingsDataModel: buildingsDataModel, amenitiesDataModel:amenitiesDataModel, favoritesManagerModel: favoritesManagerModel, networkMonitor: networkMonitor)
                        }
                        .tabItem {
                            VStack {
                                Label("Search", systemImage: "magnifyingglass")
                            }
                            .padding(.top, 10)
                        }
                    // Map Tab
                    MapBuildingsView()
                        .tabItem {
                            VStack {
                                Label("Map", systemImage: "map")
                            }
                            .padding(.top, 10)
                        }
                    // Favorites Tab
                    NavigationView {
                        FavoritesBuildingsView(buildingsDataModel: buildingsDataModel, amenitiesDataModel: amenitiesDataModel, favoritesManagerModel: favoritesManagerModel, networkMonitor: networkMonitor)
                        }
                        .tabItem {
                            VStack {
                                Label("Favorites", systemImage: "heart")
                            }
                            .padding(.top, 10)
                        }
                    // About Tab
                    InfoView()
                        .tabItem {
                            VStack{
                                Label("About", systemImage: "info.circle")
                            }
                            .padding(.top, 10)
                        }
                }
                .edgesIgnoringSafeArea(.all)
//                .onAppear {
//                       locationManager.startUpdatingLocation()
//                   }
    } // end body view
}

#Preview {
    ContentView()
}
