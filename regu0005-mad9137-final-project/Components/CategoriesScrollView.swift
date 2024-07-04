//
//  CategoriesScrollView.swift
//  regu0005-mad9137-final-project
//
//  Created by Gustavo Reguerin on 2023-12-07.
//

import SwiftUI

struct CategoriesScrollView: View {
    @ObservedObject var categoriesDataModel : CategoriesDataModel
    @ObservedObject var buildingsDataModel : BuildingsDataModel
    @ObservedObject var amenitiesDataModel : AmenitiesDataModel
    @ObservedObject var favoritesManagerModel: FavoritesManagerModel
    
    var networkMonitor: NetworkMonitorService
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedCategoryId: Int?
    @State private var isNavigationActive = false
    
    // Constants for layout
    let gridSpacing:    CGFloat = 20
    let cardWidth:      CGFloat = 154
    let cardHeight:     CGFloat = 80
    let imageHeight:    CGFloat = 100
    
    var body: some View {
        VStack {
                HStack {
                    Text("Builds Categories")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    Spacer()
//                    Text("See more")
//                        .padding(.horizontal,20)
                    
                }.padding(.top, 15)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(categoriesDataModel.categories, id: \.id) { category in
                        Button(action: {
                            selectedCategoryId = category.id
                            isNavigationActive = true
                        }) {
                            VStack() {
                                Spacer()
                                Text(category.category)
                                    .font(Font.system(size: 14))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                                Spacer()
                            }
                            .padding(.top, 5)
                            .frame(width: cardWidth, height: cardHeight)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.09), radius: 5, x: 0, y: 2)
                        }
                    }
                    .padding(.bottom, 5)
                } // lazyVGrid
                .padding(.horizontal)
            
                if let selectedCategoryId = selectedCategoryId {
                    NavigationLink(destination: BuildingsByCategoryView(buildingsDataModel: buildingsDataModel, amenitiesDataModel: amenitiesDataModel, favoritesManagerModel: favoritesManagerModel, networkMonitor: networkMonitor, categoryId: selectedCategoryId), isActive: $isNavigationActive) {
                        EmptyView()
                    }
                    .hidden()
                }
        } // VStack
        .padding(.horizontal)
        
    }
    
    var textColor: Color {
        return colorScheme == .dark ? .gray : .secondary
    }
}
