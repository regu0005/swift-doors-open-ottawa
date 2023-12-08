//
//  CategoriesScrollView.swift
//  regu0005-mad9137-final-project
//
//  Created by Gustavo Reguerin on 2023-12-07.
//

import SwiftUI

struct CategoriesScrollView: View {
    @ObservedObject var categoriesDataModel : CategoriesDataModel
    @Environment(\.colorScheme) var colorScheme
    
    // Constants for layout
    let gridSpacing:    CGFloat = 20
    let cardWidth:      CGFloat = 170
    let cardHeight:     CGFloat = 80
    let imageHeight:    CGFloat = 100
    
    var body: some View {
        VStack {
                HStack {
                    Text("Builds Categories")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        
                    Spacer()
                    
                    Text("See more")
                        .padding(.horizontal,20)
                    
                }.padding(.top, 15)
            
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                
                    ForEach(categoriesDataModel.categories, id: \.id) { category in
                                    
                                    VStack() {
                                        Spacer()
                                        Text(category.category)
                                            .font(Font.system(size: 14))
                                            .multilineTextAlignment(.center)
                                            .padding(.horizontal)
                                        Spacer()
                                    }
                                    .padding(.top, 5)
                                    .frame(width: cardWidth, height: cardHeight)
                                    .background(Color.white)
                                    .cornerRadius(10)
//                                    .shadow(radius: 1)
                                    .shadow(color: Color.black.opacity(0.09), radius: 5, x: 0, y: 2)
                                
                            }
                            .padding(.bottom, 5)
                } // lazyVGrid
                .padding(.horizontal)
        } // VStack
        .padding(.horizontal)
        
    }
    
    var textColor: Color {
        return colorScheme == .dark ? .gray : .secondary
    }
}

#Preview {
    CategoriesScrollView(categoriesDataModel:CategoriesDataModel())
}
