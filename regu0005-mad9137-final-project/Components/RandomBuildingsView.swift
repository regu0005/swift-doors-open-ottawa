//
//  RandomBuildingsView.swift
//  regu0005-mad9137-final-project
//
//  Created by Gustavo Reguerin on 2023-12-07.
//

import SwiftUI

struct RandomBuildingsView: View {
    @ObservedObject var buildingsDataModel : BuildingsDataModel
    @ObservedObject var amenitiesDataModel : AmenitiesDataModel
    @ObservedObject var favoritesManagerModel: FavoritesManagerModel
    var networkMonitor: NetworkMonitor
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        VStack {
            Text("Today's Random Buildings")
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            HStack
            {
                Spacer()
            }
            
            if buildingsDataModel.randomBuildings.isEmpty {
                            Text("Loading Buildings...")
            }
            else {
                ForEach(buildingsDataModel.randomBuildings, id: \.id) { building in

                    NavigationLink(destination: BuildingDetailView(buildingsDataModel: buildingsDataModel, amenitiesDataModel: amenitiesDataModel, favoritesManagerModel: favoritesManagerModel, networkMonitor: networkMonitor, building: building)) {
                        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                            PlaceUI(
                                title: building.name,
                                description: building.address,
                                visits: building.visits,
                                image: building.image!,
                                distance: building.distance!
                            )
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
        .padding(.bottom,60)
    }
}
