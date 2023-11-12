//
//  DessertRowView.swift
//  Cake
//
//  Created by Aaron Wilson on 11/6/23.
//

import SwiftUI

struct DessertRowView: View {
    
    let dessert: Dessert
    let image: QuickAsyncImage
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                image
                    .frame(width: 100, height: 100) // default alignment is center
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text(dessert.meal)
                    .font(.title2)
                    .tint(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .tint(.primary)
            }
            
            Divider()
        }
       
    }
}
