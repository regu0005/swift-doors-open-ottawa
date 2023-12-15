//
//  SearchBuildingsView.swift
//  regu0005-mad9137-final-project
//
//  Created by Gustavo Reguerin on 2023-12-08.
//

import SwiftUI

struct SearchBuildingsView: View {
    @ObservedObject var buildingsDataModel : BuildingsDataModel
    @ObservedObject var amenitiesDataModel : AmenitiesDataModel
    @ObservedObject var favoritesManagerModel: FavoritesManagerModel
    var networkMonitor: NetworkMonitor
    
    
    @State private var searchText = ""
    @Environment(\.colorScheme) var colorScheme
    @State private var showingFilterSheet = false
    @State private var flagApplyFilter = false
    @State private var filteredBuildings: [PostBuilding] = []
    
    var body: some View {
        ScrollView{
            Text("List of Buildings")
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 5)
            
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.leading, 8)
                    
                    TextField("Search for a building", text: $searchText)
                        .onSubmit {
                                updateFilteredBuildings()
                            }
                }
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
                
                Button(action: {
                    showingFilterSheet = true
                }) {
                    Image(systemName: "slider.horizontal.3")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 20)
                .sheet(isPresented: $showingFilterSheet) {
                    FilterView(amenitiesDataModel: amenitiesDataModel, buildingsDataModel: buildingsDataModel, isPresented: $showingFilterSheet, onFiltersChanged: onFiltersChanged)
                }
            }
            
            LazyVStack {
                ForEach(filteredBuildings) { building in
                    NavigationLink(destination: BuildingDetailView(buildingsDataModel: buildingsDataModel, amenitiesDataModel: amenitiesDataModel, favoritesManagerModel:favoritesManagerModel, networkMonitor: networkMonitor, building: building)) {
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text(building.name)
                                    .font(.headline)
                                    .foregroundColor(textColorTitle)
                                Text("Address: \(building.address)")
                                    .font(.subheadline)
                                    .foregroundColor(textColorDetails)
                                Text("Website: \(building.website)")
                                    .font(.subheadline)
                                    .foregroundColor(textColorDetails)
                            }
                            Spacer()
                        }
                        .padding(.horizontal,20)
                        .padding(.top,10)
                        .padding(.bottom,5)
                    } // end navigationlink
                    Divider()
                }
            } // End LazyVStack
        } // end scrollview
        .onAppear {
            updateFilteredBuildings()
        }
    }
    
    var textColorDetails: Color {
        return colorScheme == .dark ? .gray : .secondary
    }
    var textColorTitle: Color {
        return colorScheme == .dark ? .white : .black
    }
    
    func updateFilteredBuildings() {
        let result = buildingsDataModel.filterBuildings(
            selectedAmenities: amenitiesDataModel.selectedAmenities,
            searchText: searchText
        )

        DispatchQueue.main.async {
            self.buildingsDataModel.filteredBuildingsCount = result.count
        }

        self.filteredBuildings = result
    }
    
    func onFiltersChanged() {
           updateFilteredBuildings()
    }

}

#Preview {
    SearchBuildingsView(buildingsDataModel:BuildingsDataModel(), amenitiesDataModel:AmenitiesDataModel(), favoritesManagerModel: FavoritesManagerModel() ,networkMonitor:NetworkMonitor())
}
