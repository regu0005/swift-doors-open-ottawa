//
//  FilterView.swift
//  regu0005-mad9137-final-project
//
//  Created by Gustavo Reguerin on 2023-12-09.
//

import SwiftUI

struct FilterView: View {
    @ObservedObject var amenitiesDataModel : AmenitiesDataModel
    @ObservedObject var buildingsDataModel : BuildingsDataModel
    @Binding var isPresented: Bool
    @State private var optionEnabled = false
    var onFiltersChanged: () -> Void
    
    var body: some View {
        NavigationView {
                    List {
                        Section(header: Text("Sort").font(.title3).bold()) {
                            Toggle("Most Visited", isOn: $optionEnabled).disabled(true)
                            Toggle("Closest", isOn: $optionEnabled).disabled(true)
                        }

                        Section(header: Text("Amenities").font(.title3).bold()) {
                            ForEach(amenitiesDataModel.amenities) { amenity in
                                Toggle(amenity.amenity, isOn: Binding(
                                    get: { amenitiesDataModel.selectedAmenities.contains(amenity.id) },
                                    set: { isSelected in
                                        if isSelected {
                                            amenitiesDataModel.selectedAmenities.insert(amenity.id)
                                        } else {
                                            amenitiesDataModel.selectedAmenities.remove(amenity.id)
                                        }
                                        print("Updated Selected Amenities: \(amenitiesDataModel.selectedAmenities)")
                                    }
                                ))
                            } // end foreach

                            Button(action: {
                                isPresented = false
                            }) {
                                HStack {
                                    Text("Buildings Found: \(buildingsDataModel.filteredBuildingsCount)")
                                        .foregroundColor(.white)
                                    Spacer()
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.white)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(10)
                            }
                        }
                    }
                    .navigationTitle("Filters")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                isPresented = false
                            }) {
                                Image(systemName: "xmark")
                            }
                        }
                    }
        } // end navigationview
        .onChange(of: amenitiesDataModel.selectedAmenities) { oldValue, newValue in
            if oldValue != newValue {
                onFiltersChanged()
                print("Amenities filter applied")
            }
        }
    }
}
