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
    
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        ZStack(alignment: .bottom) {
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
                            HeroSectionView(buildingsDataModel:buildingsDataModel)
                            CategoriesScrollView(categoriesDataModel: categoriesDataModel)
                            RandomBuildingsView(buildingsDataModel: buildingsDataModel)
                            BuildingsByAmenitiesView()
                        }
                    }
                    .edgesIgnoringSafeArea(.all)
                    .navigationBarTitle("Buildings Home", displayMode: .inline)
                    .navigationBarHidden(true)
                }
            }
            
            // Main content view
               switch selectedTab {
               case .home:
                   HomeView()
               case .search:
                   SearchView()
               case .map:
                   MapView()
               case .favorites:
                   FavoritesView()
               case .about:
                   AboutView()
               }

            HStack{
                CustomTabBar(selectedTab: $selectedTab)
                    .background(Color.white.opacity(0.85))
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 1)
                    .padding(.top, 15)
            }
            .background(Color.white.opacity(0.92))
        }
        
        
    } // end body view
    
    enum Tab {
            case home, search, map, favorites, about
        }
}

struct CustomTabBar: View {
    @Binding var selectedTab: ContentView.Tab

    var body: some View {
        HStack {
            TabBarButton(iconName: "house", tab: .home)
            TabBarButton(iconName: "magnifyingglass", tab: .search)
            TabBarButton(iconName: "map", tab: .map)
            TabBarButton(iconName: "heart", tab: .favorites)
            TabBarButton(iconName: "info.bubble", tab: .about)
        }
        .padding(.horizontal,20)
        .padding(.bottom,15)
        .padding(.top,15)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }

    func TabBarButton(iconName: String, tab: ContentView.Tab) -> some View {
        Button(action: {
            withAnimation {
                selectedTab = tab
            }
        }) {
            Image(systemName: iconName)
                .font(.system(size: 22))
                .foregroundColor(selectedTab == tab ? .blue : .gray)
                .padding()
        }
    }
}

struct HomeView: View {
    var body: some View {
        Text("Home")
    }
}
struct SearchView: View {
    var body: some View {
        Text("Search")
    }
}
struct MapView: View {
    var body: some View {
        Text("Map")
    }
}
struct FavoritesView: View {
    var body: some View {
        Text("Favorites")
    }
}
struct AboutView: View {
    var body: some View {
        Text("About")
    }
}

#Preview {
    ContentView()
}
