//
//  SearchBuildingsView.swift
//  regu0005-mad9137-final-project
//
//  Created by Gustavo Reguerin on 2023-12-08.
//

import SwiftUI
import CoreLocation

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
    
    @State private var distanceOrder: DistanceOrder = .closestToFarthest

    
    func formattedDistance(distance: CLLocationDistance?) -> String {
        guard let distance = distance else {
            return "N/A Km"
        }
        return String(format: "%.2f Km", distance)
    }
    
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
                        .textInputAutocapitalization(.none)
                        .onSubmit {
                                updateFilteredBuildings()
                            }
                        .submitLabel(.search)
                        .padding(.vertical, 7)
                }
                .padding(EdgeInsets(top: 7, leading: 7, bottom: 7, trailing: 7))
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
                    FilterView(amenitiesDataModel: amenitiesDataModel, buildingsDataModel: buildingsDataModel, isPresented: $showingFilterSheet, distanceOrder: $distanceOrder, onFiltersChanged: onFiltersChanged)
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
                                    .lineLimit(nil)
                                    .fixedSize(horizontal: false, vertical: true)
                                Text("Address: \(building.address)")
                                    .font(.subheadline)
                                    .foregroundColor(textColorDetails)
                                    .lineLimit(nil)
                                    .fixedSize(horizontal: false, vertical: true)
                                Text("Distance: \(formattedDistance(distance: building.distance))")
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
        // Filter by amenities and searchtext
        var result = buildingsDataModel.filterBuildings(
            selectedAmenities: amenitiesDataModel.selectedAmenities,
            searchText: searchText
        )

        // Sort by distance
        switch distanceOrder {
            case .closestToFarthest:
                result.sort { ($0.distance ?? Double.infinity) < ($1.distance ?? Double.infinity) }
            case .farthestToClosest:
                result.sort { ($0.distance ?? Double.infinity) > ($1.distance ?? Double.infinity) }
            }

        DispatchQueue.main.async {
                self.filteredBuildings = result
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
