//
//  InfoView.swift
//  regu0005-mad9137-final-project
//
//  Created by Gustavo Reguerin on 2023-12-08.
//

import SwiftUI

struct InfoView: View {
    let name: String = "Gustavo Reguerin"
    let major: String = "Mobile Application Design and Development"
    let bio: String = "Luis Gustavo Reguerin Acarapi, a Systems Engineer and Full Stack Developer, specializes in mobile app development. With a solid educational foundation from Algonquin College in Mobile App Design and Development, he effectively integrates his extensive experience in monitoring and web systems, particularly within the transport sector, into innovative mobile solutions. His expertise represents a harmonious blend of technical knowledge and practical application, marking him as a key contributor in the field of mobile technologies."
    let imageName: String = "Gustavo_Reguerin"

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
//                    .shadow(radius: 10)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 6)
                    .padding(.top, 50)

                Text(name)
                    .font(.title)
                    .fontWeight(.bold)

                Text(major)
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal,20)

                Text(bio)
                    .font(.body)
                    .padding(.horizontal,30)
                    .font(Font.system(size: 14))
            }
        }
        .navigationBarTitle("Developer about", displayMode: .inline)
    }
}

#Preview {
    InfoView()
}
