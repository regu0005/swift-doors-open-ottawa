//
//  SplashScreenView.swift
//  regu0005-mad9137-final-project
//
//  Created by Gustavo Reguerin on 2023-12-07.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if(isActive) {
//            ContentView()
            NetUI()
        }
        else
        {
            VStack {
                VStack {
                    Image("ic_logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180, height: 180)
                    Text("Doors Open Ottawa")
                        .font(Font.title)
                        .bold()
                    Text("Gustavo Reguerin")
                        .font(.body)
                        .padding(.top, 40)
                    Text("MADD 2023")
                        .font(.footnote)
                        .padding(.top, 30)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
//                    withAnimation(.easeIn(duration: 1.0)) {
                        self.size = 0.9
                        self.opacity = 1.0
//                    }
                }
            }
            .onAppear(){
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0){
                    withAnimation{
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
