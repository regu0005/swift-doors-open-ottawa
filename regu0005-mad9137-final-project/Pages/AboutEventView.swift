//
//  AboutEventView.swift
//  regu0005-mad9137-final-project
//
//  Created by Gustavo Reguerin on 2023-12-15.
//

import SwiftUI

struct AboutEventView: View {
    let name: String = "Doors Open Ottawa"
    let detail: String = "Doors Open Ottawa is an esteemed annual event that offers an exclusive glimpse into the heart of Ottawa’s most intriguing and charming buildings. This event is part of the global 'Doors Open' initiative and stands as a testament to Ottawa’s rich architectural heritage and vibrant history. \n\nEach year, a diverse array of buildings - many of which are not typically accessible to the public – open their doors for this special occasion. Participants are afforded a rare opportunity to explore behind the scenes of various architectural marvels, encompassing government buildings, embassies, historic homes, museums, places of worship, and more.\n\nDoors Open Ottawa is more than just an event; it is a celebration of our city's culture, history, and design. It aims to foster a deeper understanding and appreciation of Ottawa's built environment and to connect the community to its urban landscape. The event is free of charge, inviting everyone to engage in this enriching experience.\n\nWhether you are a resident or a visitor, a history enthusiast or an architecture aficionado, Doors Open Ottawa promises a unique and memorable experience, unveiling the hidden gems that shape the character of our capital city.\n\nJoin us in this annual adventure to discover the stories behind Ottawa’s most fascinating buildings. Stay tuned for updates on participating locations and event details for this year's Doors Open Ottawa.\n\n"
        
    let imageName: String = "logo"

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .padding(.top, 50)

                Text(name)
                    .font(.title)
                    .fontWeight(.bold)

                Text(detail)
                    .font(.body)
                    .padding(.horizontal,30)
                    .font(Font.system(size: 14))
            }
        }
        .navigationBarTitle("About the Event", displayMode: .inline)
    }
}

#Preview {
    AboutEventView()
}
