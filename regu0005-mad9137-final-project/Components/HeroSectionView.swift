//
//  HeroSectionView.swift
//  regu0005-mad9137-final-project
//
//  Created by Gustavo Reguerin on 2023-12-07.
//

import SwiftUI

struct HeroSectionView: View {
    @ObservedObject var buildingsDataModel : BuildingsDataModel
        
    @State private var currentImageIndex = 0
    @State private var imageLoadState = ImageLoadState.loading
    @State private var imageScale: CGFloat = 0.9
    
    @State private var textOpacity = 0.0
    
    let timer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            if let building = buildingsDataModel.getTopThreeVisitedBuildings().enumerated().first(where: { $0.offset == currentImageIndex })?.element {

                AsyncImage(url: URL(string: building.image ?? "")) { phase in
                    switch phase {
                    case .empty:
                        Color.clear
                            .frame(maxWidth: .infinity, maxHeight: 260)
                        ProgressView()
                            .font(.headline)
                            .bold()
                            .onAppear {
                                imageLoadState = .loading
                                imageScale = 1.0
                            }

                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .scaleEffect(imageScale)
                            .transition(.opacity)
                            .onAppear {
                                if imageLoadState != .loaded {
                                    withAnimation(.easeIn(duration: 4.2)) {
                                        imageScale = 1.1
                                        imageLoadState = .loaded
                                    }
                                }
                            }

                    case .failure:
                        Image("placeholder_image")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .onAppear {
                                imageLoadState = .failed
                                imageScale = 1.0
                            }

                    @unknown default:
                        EmptyView()
                    }
                }
                .id(currentImageIndex)
                .frame(maxWidth: .infinity, maxHeight: 260)
                .clipped()
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                .onReceive(timer) { _ in
                    withAnimation(.easeInOut(duration: 3.0)) {
                        currentImageIndex = (currentImageIndex + 1) % buildingsDataModel.getTopThreeVisitedBuildings().count
                        imageLoadState = .loading
                        imageScale = 1.0
                    }
                } // end asyncimage
                
                VStack(alignment: .trailing, spacing: 10) {
                    Text(building.name)
                        .font(Font.system(size: 14))
                        .italic()
                        .padding(.top, 280)
                        .opacity(textOpacity) 
                        .onAppear {
                            withAnimation(.smooth(duration: 0.5)) {
                                textOpacity = 1.0
                            }
                        }
                            .padding(.leading, 40)
                            .padding(.horizontal, 16)
                
                ////                                Text(building.address)
                ////                                    .font(Font.system(size: 12))
                ////                                    .foregroundColor(.secondary)
                ////                                    .padding(.top, -10)
                ////                                    .padding(.horizontal, 20)
                }
            }
        }
        .frame(height: 278)
        .padding(.top, -10)
        .edgesIgnoringSafeArea(.all)
    }
    
    enum ImageLoadState {
            case loading, loaded, failed
        }
}

#Preview {
    HeroSectionView(buildingsDataModel: BuildingsDataModel())
}
