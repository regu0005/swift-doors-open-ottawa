//
//  PlaceUI.swift
//  regu0005-mad9137-final-project
//
//  Created by Gustavo Reguerin on 2023-12-07.
//

import SwiftUI



struct PlaceUI: View {
    
    var title: String
    var description: String
    var image: String
    var visits: Int
    
    @State private var imageOpacity = 0.0
    @State private var isMainImageLoaded = false

    init(title: String, description: String, visits: Int ,image: String) {

        self.title = title
        self.description = description
        self.visits = visits
        self.image = image
    }
    
    var body: some View {
        HStack {

            // Spacer()
            // leading align the text and the image to the border left

            // spacing: do a distance between the image and text in the VStack

            VStack(alignment: .leading, spacing: 14) {

//                Image(image)
//                    .resizable()
//                    .frame(width: 360, height: 200)
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top))
                {
                    if(!isMainImageLoaded) {
                        ProgressView("...")
                            .font(.headline)
                            .bold()
                    }
                    
                    AsyncImage(url: URL(string: image )) { phase in
                        
                        switch phase {
                        case .empty:
                                ProgressView("...")
                                    .font(.headline)
                                    .bold()
    //                        Image("world_default")
    //                            .resizable()
    //                            .aspectRatio(contentMode: .fill)
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .opacity(imageOpacity)
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        imageOpacity = 1.0
                                        isMainImageLoaded = true
                                    }
                                }
                        case .failure:
                            Image("algonquin")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            
                            
                        @unknown default:
                            Image("algonquin")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .clipped()
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 6)
                    
                    Button(action: {
                        //favoritesManagerModel.toggleFavorite(countryID: country.id)
                    }) {
                        Image(systemName: "heart.fill"
                            //systemName: favoritesManagerModel.favorites[country.id, default: false] ? "heart.fill" : "heart"
                            )
                            .foregroundColor(.red)
                            .font(.system(size: 30))
                            .padding(.top, 180)
                            .padding(.trailing, 10)
                            .padding(.trailing)
                    }
                    
                    Button(action: {
                        //favoritesManagerModel.toggleFavorite(countryID: country.id)
                    }) {
                        Image(systemName: "square.and.arrow.up.fill"
                            //systemName: favoritesManagerModel.favorites[country.id, default: false] ? "heart.fill" : "heart"
                            )
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .padding(.top, 173)
                            .padding(.trailing, 64)
                            .padding(.trailing)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 200)

                cardText.padding(.horizontal, 14)
            }

//            .onTapGesture(count: 2) {

//                print("Tapped 2")

//            }

//            .onLongPressGesture(){

//                print("Long press")

//            }

            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
//            .shadow(radius: 6)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
            .padding(.bottom, 20)

//            Spacer()

        }
        .frame(width: 360)
    }

    

    var cardText: some View {

        VStack(alignment: .leading) {

            HStack{

                Text(title)
                    .font(.headline)
                    .padding(.bottom,2)
                    .foregroundColor(.black)

                Spacer()

                VStack{

                    HStack{
                        
                        Image(systemName: "star.fill")
                            .font(.system(size: 12))

                        Image(systemName: "star.fill")
                            .font(.system(size: 12))

                        Image(systemName: "star.fill")
                            .font(.system(size: 12))

                        Image(systemName: "star.fill")
                            .font(.system(size: 12))

                        Image(systemName: "star.fill")
                            .font(.system(size: 12))

                    }

                    Text("Visits: \(visits)")
                        .font(.system(size: 14))
                }
                .foregroundColor(Color.orange)
            }

            Text(description)
                .foregroundColor(.black)

            VStack (alignment: .trailing ){

                HStack{

                    Spacer()

                    Image(systemName: "binoculars.fill")

                    Image(systemName: "fork.knife")

                }
            }
            .foregroundColor(.gray)
            .padding(.bottom, 16)
        }
    }

}

#Preview {
    //PlaceUI()
    PlaceUI(title: "demo", description: "test", visits: 123, image: "niagara")
}
