//
//  MenuItemView.swift
//  AkakceApp
//
//  Created by Deniz Ata Eş on 12.06.2023.
//

import SwiftUI
import Kingfisher

struct MenuVerticalItemView: View {
    
    var product: Product
    var body: some View {
        VStack(alignment: .leading){
            KFImage(URL(string: product.imageURL))
                .resizable()
                .scaledToFit()
                .frame(width: 128, height: 128)
            
            
            Text(product.name)
                .foregroundColor(Color(hex: "237EC4"))
                .font(.caption2)
                .padding(.bottom, 2)
            
            
            PriceView(price: product.price, fontSize: 18)
            
            HStack{
                Text("\(product.countOfPrices ?? 0) satıcı")
                    .font(.system(size: 10))
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 8, height: 11)
            }
            .padding(.bottom,4)
            
            Text("\(product.followCount ?? 0)+ takip")
                .font(.system(size: 10))
        }
        .frame(width: 140, height: 250)
        .padding()
        .background(.white)
        .cornerRadius(3)
        .shadow(color: .blue.opacity(0.2), radius: 1)
        
    }
}

struct MenuVerticalItemView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
