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
            // ContentView()
            NetUI()
        }
        else
        {
            ZStack {
                Color(#colorLiteral(red: 0.227, green: 0.380, blue: 0.600, alpha: 1))
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack {
                        Image("ic_logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 180, height: 180)
                        Text("Doors Open Ottawa")
                            .font(Font.title)
                            .bold()
                            .foregroundColor(.white)
                        Text("Gustavo Reguerin")
                            .font(.body)
                            .bold()
                            .padding(.top, 40)
                            .foregroundColor(.white)
                        Text("MADD 2023")
                            .font(.footnote)
                            .bold()
                            .padding(.top, 20)
                            .foregroundColor(.white)
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        //  withAnimation(.easeIn(duration: 1.0)) {
                        self.size = 0.9
                        self.opacity = 1.0
                        //  }
                    }
                }
            }
            .onAppear(){
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
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
