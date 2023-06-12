//
//  MenuItemView.swift
//  AkakceApp
//
//  Created by Deniz Ata Eş on 12.06.2023.
//

import SwiftUI
import Kingfisher

struct MenuItemView: View {
    
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
            
            
            HStack(spacing: 2){
                Text("\( String(format: "%.2f", product.price))")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                Text(",00 TL")
                    .font(.system(size: 9))
                
            }
            
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
    }
}

struct MenuItemView_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemView(product: Product(code: 1, imageURL: "yok", name: "iphone", dropRatio: 12, price: 12, countOfPrices: 12, followCount: 12))
    }
}
