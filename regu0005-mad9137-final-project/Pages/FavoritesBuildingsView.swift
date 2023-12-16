//
//  FavoritesBuildingsView.swift
//  regu0005-mad9137-final-project
//
//  Created by Gustavo Reguerin on 2023-12-08.
//

import SwiftUI

struct FavoritesBuildingsView: View {
    @ObservedObject var buildingsDataModel : BuildingsDataModel
    @ObservedObject var amenitiesDataModel : AmenitiesDataModel
    @ObservedObject var favoritesManagerModel: FavoritesManagerModel
    var networkMonitor: NetworkMonitorService
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView{
            Text("List of Favorites")
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 5)
                .padding(.bottom, 15)
            
            LazyVStack {
                ForEach(favoriteBuildings, id: \.id) { building in
                    
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
                    } // End NavigationLink
                }
            }
        }
    }


    private var favoriteBuildings: [PostBuilding] {
        buildingsDataModel.buildings.filter { building in
            favoritesManagerModel.getFavorites().keys.contains(building.id)
        }
    }

    var textColorDetails: Color {
        return colorScheme == .dark ? .gray : .secondary
    }
    var textColorTitle: Color {
        return colorScheme == .dark ? .white : .black
    }
}

#Preview {
    FavoritesBuildingsView(buildingsDataModel: BuildingsDataModel(), amenitiesDataModel: AmenitiesDataModel(), favoritesManagerModel: FavoritesManagerModel(), networkMonitor: NetworkMonitorService())
}
