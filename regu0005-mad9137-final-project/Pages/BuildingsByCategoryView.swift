//
//  BuildingsByCategoryView.swift
//  regu0005-mad9137-final-project
//
//  Created by Gustavo Reguerin on 2023-12-15.
//

import SwiftUI

struct BuildingsByCategoryView: View {
    @ObservedObject var buildingsDataModel : BuildingsDataModel
    @ObservedObject var amenitiesDataModel : AmenitiesDataModel
    @ObservedObject var favoritesManagerModel: FavoritesManagerModel
    
    var networkMonitor: NetworkMonitor
    var categoryId: Int
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView{
            Text("Buildings by Category")
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 5)
                .padding(.bottom, 15)
            
            LazyVStack {
                if buildingsDataModel.randomBuildings.isEmpty {
                                Text("Loading Buildings")
                }
                else {
                    let filteredBuildings = buildingsDataModel.filterBuildingsByCategory(idCategory: categoryId)
                    ForEach(filteredBuildings, id: \.id) { building in

                        NavigationLink(destination: BuildingDetailView(buildingsDataModel: buildingsDataModel, amenitiesDataModel: amenitiesDataModel, favoritesManagerModel: favoritesManagerModel, networkMonitor: networkMonitor, building: building)) {
                            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                                PlaceUI(
                                    title: building.name,
                                    description: building.address,
                                    visits: building.visits,
                                    image: building.image!,
                                    distance: building.distance!
                                )
                                
                                ShareLink(
                                    Text(""),
                                    item: "logo",
                                    subject: Text(building.name),
                                    message: Text("\(building.name) .- \(building.description!)"),
                                    preview: SharePreview(Text(building.name))
                                )
                                .font(.system(size: 30))
                                .padding(.trailing, 64)
                                .padding(.top, 148)
                                .padding(.horizontal,14)
                                .foregroundColor(.white)
                                
                                Button(action: {
                                    favoritesManagerModel.toggleFavorite(buildingID: building.id)
                                }) {
                                    Image(systemName: favoritesManagerModel.favorites[building.id, default: false] ? "heart.fill" : "heart.fill")
                                        .font(.system(size: 30))
                                        .foregroundColor(favoritesManagerModel.favorites[building.id, default: false] ? Color.red : Color.white)
                                }
                                .padding(.top, 155)
                                .padding(.trailing, 20)
                            }
                            
                        }
                    }
                    .onAppear {
                        buildingsDataModel.updateRandomBuildings()
                    }
                }
            }
        }
        .padding(.bottom,60)
    }
}
