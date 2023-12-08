//
//  RandomBuildingsView.swift
//  regu0005-mad9137-final-project
//
//  Created by Gustavo Reguerin on 2023-12-07.
//

import SwiftUI

struct RandomBuildingsView: View {
    @ObservedObject var buildingsDataModel : BuildingsDataModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack{
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
                    
                    ForEach(buildingsDataModel.getRandomBuildings(), id: \.id) { building in
                        
                        PlaceUI(title: building.name, description: building.address, visits: building.visits ,image: building.image!)
                    }
            }

            Spacer()

            ZStack {
                HStack {

                    Image(systemName: "thermometer.sun.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                    Text("72 F")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "drop.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.white)

                    Text("40%")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .padding(20)
                .zIndex(1)

                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
                    .frame(height: 60)
            }
            .padding(.horizontal,20)
        }
        .background(Color(.white))
    }
}

#Preview {
    RandomBuildingsView(buildingsDataModel: BuildingsDataModel())
}
