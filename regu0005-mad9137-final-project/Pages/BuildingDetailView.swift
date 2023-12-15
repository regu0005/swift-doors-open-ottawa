//
//  BuildingDetailView.swift
//  regu0005-mad9137-final-project
//
//  Created by Gustavo Reguerin on 2023-12-10.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D
    var capitalName: String

    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = capitalName
        uiView.addAnnotation(annotation)
    }
}

struct BuildingDetailView: View {
    @ObservedObject var buildingsDataModel : BuildingsDataModel
    @ObservedObject var amenitiesDataModel : AmenitiesDataModel
    @ObservedObject var favoritesManagerModel: FavoritesManagerModel
    var networkMonitor: NetworkMonitor
    var building: PostBuilding
    
    @State private var isFavorite: Bool = false
    @State private var isMapFullscreen = false
    @State private var isMainImageLoaded = false
    @State private var imageOpacity = 0.0
    @State private var showAllAmenities = false
    @State private var expandedText = false
    @State private var textLinesLimit: Int? = 3

    
    var body: some View {
        
        ScrollViewReader { scrollViewProxy in
            ScrollView {
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                    
                    if(!isMainImageLoaded) {
                        ProgressView("...")
                            .font(.headline)
                            .bold()
                    }
                    
                    AsyncImage(url: URL(string: building.image ?? "")) { phase in
                        
                        switch phase {
                        case .empty:
//                            ProgressView("...")
//                                .font(.headline)
//                                .bold()
                            Image("placeholder_image")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
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
                            Image("placeholder_image")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            
                            
                        @unknown default:
                            Image("placeholder_image")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 260)
                    .clipped()
                    .edgesIgnoringSafeArea(.all)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
            
                    Button(action: {
                        favoritesManagerModel.toggleFavorite(buildingID: building.id)
                    }) {
                        Image(systemName: favoritesManagerModel.favorites[building.id, default: false] ? "heart.fill" : "heart.fill")
                            .font(.system(size: 30))
                            .foregroundColor(favoritesManagerModel.favorites[building.id, default: false] ? Color.red : Color.white)
                    }
                    .padding(.top, 210)
                    .padding(.trailing, 20)
                }
                .frame(maxWidth: .infinity, maxHeight: 260)
                
                Text(building.name)
                        .font(Font.system(size: 22))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top, 5)
                HStack {
                    Text("\(building.category)")
                            .font(Font.system(size: 18))
                            .bold()
                            .frame(alignment: .leading)
                            .padding(.horizontal)
                            
                            .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.top,0)
                
                HStack(alignment: .top) {
                    Text("Website:")
                            .font(Font.system(size: 16))
                            .frame(maxWidth: 70, alignment: .leading)
                            .padding(.top,1)
                            .padding(.leading,30)
                            .foregroundColor(.gray)
                    Text("\(building.website)")
                            .font(Font.system(size: 16))
                            .frame(alignment: .leading)
                            .padding(.horizontal)
                            .padding(.top,1)
                            .foregroundColor(.gray)
                    Spacer()
                }
                if let email = building.email, !email.isEmpty {
                    HStack(alignment: .top) {
                        Text("Email:")
                            .font(Font.system(size: 16))
                            .frame(maxWidth: 70, alignment: .leading)
                            .padding(.top,1)
                            .padding(.leading,30)
                            .foregroundColor(.gray)
                        Text(email)
                            .font(Font.system(size: 16))
                            .frame(alignment: .leading)
                            .padding(.horizontal)
                            .padding(.top,1)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                }

                if let phoneNumber = building.phoneNumber, !phoneNumber.isEmpty {
                    HStack(alignment: .top) {
                        Text("Phone:")
                            .font(Font.system(size: 16))
                            .frame(maxWidth: 70, alignment: .leading)
                            .padding(.top,1)
                            .padding(.leading,30)
                            .foregroundColor(.gray)
                        Text(phoneNumber)
                            .font(Font.system(size: 16))
                            .frame(alignment: .leading)
                            .padding(.horizontal)
                            .padding(.top,1)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                }
                
                if let cellphoneNumber = building.cellphoneNumber, !cellphoneNumber.isEmpty {
                    HStack(alignment: .top) {
                        Text("Cell Phone:")
                            .font(Font.system(size: 16))
                            .frame(maxWidth: 70, alignment: .leading)
                            .padding(.top,1)
                            .padding(.leading,30)
                            .foregroundColor(.gray)
                        Text(cellphoneNumber)
                            .font(Font.system(size: 16))
                            .frame(alignment: .leading)
                            .padding(.horizontal)
                            .padding(.top,1)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                }
                
                HStack(alignment: .top) {
                    Text("Address:")
                            .font(Font.system(size: 16))
                            .frame(maxWidth: 70, alignment: .leading)
                            .padding(.top,1)
                            .padding(.leading,30)
                            .foregroundColor(.gray)
                    Text("\(building.address)")
                            .font(Font.system(size: 16))
                            .frame(alignment: .leading)
                            .padding(.horizontal)
                            .padding(.top,1)
                            .foregroundColor(.gray)
                    Spacer()
                }
                
                HStack(alignment: .top) {
                    Text("Picture:")
                            .font(Font.system(size: 16))
                            .frame(maxWidth: 70, alignment: .leading)
                            .padding(.top,1)
                            .padding(.leading,30)
                            .foregroundColor(.gray)
                    Text(building.imageDescription!)
                            .font(Font.system(size: 14))
                            .frame(alignment: .leading)
                            .padding(.horizontal)
                            .padding(.top,1)
                            .foregroundColor(.gray)
                    Spacer()
                }
                    
                VStack{
                    HStack {
                        Text("Description")
                            .font(.title3)
                            .bold()
                            .padding(.top,10)
                            .padding(.leading, 20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        Button(action: {
                            expandedText.toggle()
                            textLinesLimit = expandedText ? nil : 3
                        }) {
                            Text(expandedText ? "See less" : "See more")
                                .foregroundColor(.blue)
                                .font(Font.system(size: 16))
                        }
                        .padding()
                    }
                    
                    Text(building.description ?? " ")
                            .font(Font.system(size: 16))
                            .padding(.horizontal, 20)
                            .lineLimit(textLinesLimit)
                }
                
                VStack {
                    HStack {
                        Text("Open Hours")
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                    }
                    VStack(alignment: .leading) {
                        ForEach(building.schedules!, id: \.id) { schedule in
                            scheduleView(schedule)
                        }
                    }
                    .padding(.top,10)
                    .padding(.leading, 20)
                }
                .padding(.top,10)
                .padding(.leading, 20)
                
                VStack {
                    HStack {
                        Text("Amenities")
                            .font(.title3)
                            .bold()
                            .padding(.top,10)
                            .padding(.leading, 20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        Button(action: { showAllAmenities.toggle() }) {
                            Text(showAllAmenities ? "See less" : "See more")
                                .foregroundColor(.blue)
                                .font(Font.system(size: 16))
                        }
                        .padding()
                    }
                    
                    
                    if showAllAmenities {
                        VStack(alignment: .leading) {
                            ForEach(building.amenities!, id: \.id) { amenity in
                                amenityView(amenity)
                            }
                        }
                        .padding(.horizontal,40)
                    } else {
                        HStack(alignment: .top, spacing: 20) {

                            ForEach(Array(building.amenities!.prefix(2)), id: \.id) { amenity in
                                amenityViewBasic(amenity)
                            }
                        }
                        .padding(.horizontal,20)
                    }
                }
                
                VStack {
                    Text("Location")
                        .font(.title3)
                        .bold()
                        .padding(.top,10)
                        .padding(.leading, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if let latitude = Double(building.latitude ?? ""), let longitude = Double(building.longitude ?? "") {
                            let locationCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                            ZStack(alignment: .topTrailing) {
                                let markerName = building.name + " - " + building.address
                                MapView(coordinate: locationCoordinate, capitalName: markerName)
                                .frame(height: isMapFullscreen ? UIScreen.main.bounds.height : 200)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                                .id("mapView")
                                
                                Button(action: {
                                    //withAnimation {
                                        isMapFullscreen.toggle()
                                        if isMapFullscreen {
                                            scrollViewProxy.scrollTo("mapView", anchor: .top)
                                        }
                                    //}
                                }) {
                                    Image(systemName: isMapFullscreen ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right")
                                        .padding()
                                        .background(Color.white.opacity(0.7))
                                        .clipShape(Circle())
                                }
                                .padding(.trailing, 20)
                                .padding(.top, 20)
                            } // End ZStack
                            
                        } else {
                            Text("Map coordinates not available.")
                                .frame(height: 200)
                            
                        }
                }
                .edgesIgnoringSafeArea(isMapFullscreen ? .all : .init())
                
               
            }
        } // end scroll view
    } // end body view
    
    func amenityViewBasic(_ amenity: Amenity) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                if let iconURL = amenity.icon, let url = URL(string: iconURL) { 
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 24, height: 24)
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                        case .failure:
                            Image(systemName: "photo")
                                .frame(width: 24, height: 24)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Image(systemName: "photo")
                        .frame(width: 24, height: 24)
                }

                Text(amenity.amenity)
                    .font(Font.system(size: 14))
                    .foregroundColor(Color(red: 0.10, green: 0.13, blue: 0.17))
            }
        }
        .padding()
        .background(Color(red: 0.89, green: 0.91, blue: 0.94))
        .cornerRadius(6)
    }

    func amenityView(_ amenity: Amenity) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                if let iconURL = amenity.icon, let url = URL(string: iconURL) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 24, height: 24)
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                        case .failure:
                            Image(systemName: "photo")
                                .frame(width: 24, height: 24)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Image(systemName: "photo")
                        .frame(width: 24, height: 24)
                }

                Text(amenity.amenity)
                    .font(Font.system(size: 14))
                    .foregroundColor(Color(red: 0.10, green: 0.13, blue: 0.17))
            }

            if let description = amenity.description {
                Text(description)
                    .font(Font.system(size: 12))
                    .foregroundColor(Color.gray)
                    .lineLimit(nil)
            }
        }
        .padding()
        .frame(width: 340)
        .background(Color(red: 0.89, green: 0.91, blue: 0.94))
        .cornerRadius(6)
    }

    
    func getAvailableDays(schedule: Schedule) -> String {
        var days = [String]()
        if schedule.monday == 1 { days.append("Monday") }
        if schedule.tuesday == 1 { days.append("Tuesday") }
        if schedule.wednesday == 1 { days.append("Wednesday") }
        if schedule.thursday == 1 { days.append("Thursday") }
        if schedule.friday == 1 { days.append("Friday") }
        if schedule.saturday == 1 { days.append("Saturday") }
        if schedule.sunday == 1 { days.append("Sunday") }

        return days.joined(separator: ", ")
    }
    
    func scheduleView(_ schedule: Schedule) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("Open:")
                    .font(Font.system(size: 16))
                    .bold()
                Text("\(getAvailableDays(schedule: schedule))")
                    .font(Font.system(size: 16))
            }
            
            HStack {
                Text("Hours:")
                    .font(Font.system(size: 16))
                    .bold()
                HStack(spacing: 8) {
                    Text(schedule.timeIni)
                        .font(Font.system(size: 16))
                    Text(schedule.timeEnd)
                        .font(Font.system(size: 16))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
