//
//  HeroSectionView.swift
//  regu0005-mad9137-final-project
//
//  Created by Gustavo Reguerin on 2023-12-07.
//

import SwiftUI

struct HeroSectionView: View {
    @ObservedObject var buildingsDataModel : BuildingsDataModel
    
    @State private var isMainImageLoaded = false
    @State private var imageOpacity = 0.0
    
    @State private var selectedBuildingIndex = 0
    
    var body: some View {
        
        TabView(selection: $selectedBuildingIndex) {
                    ForEach(buildingsDataModel.getTopThreeVisitedBuildings(), id: \.id) { building in
                        ZStack(alignment: .topTrailing) {
                            AsyncImage(url: URL(string: building.image ?? "")) { phase in
                                switch phase {
                                case .empty:
                                    Color.clear
                                        .frame(maxWidth: .infinity, maxHeight: 260)
                                    ProgressView("...")
                                        .font(.headline)
                                        .bold()
                                    
                                case .success(let image):
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .transition(.opacity)
                                        .animation(.easeInOut(duration: 0.5), value: selectedBuildingIndex)
                                case .failure:
                                    Image("placeholder_image") // Replace with your placeholder image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: 260)
                            .clipped()

                            VStack(alignment: .trailing, spacing: 10) {
                                Text(building.name)
                                    .font(Font.system(size: 12))
//                                    .fontWeight(.bold)
                                    .italic()
                                    .padding(.top, 264)
                                    .padding(.horizontal, 16)

//                                Text(building.address)
//                                    .font(Font.system(size: 12))
//                                    .foregroundColor(.secondary)
//                                    .padding(.top, -10)
//                                    .padding(.horizontal, 20)
                            }
                        }
                        .tag(building.id)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(height: 278)
                .padding(.top,-5)
                .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    HeroSectionView(buildingsDataModel: BuildingsDataModel())
}
