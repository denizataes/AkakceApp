//
//  MenuHorizontalItemView.swift
//  AkakceApp
//
//  Created by Deniz Ata Eş on 13.06.2023.
//

import SwiftUI
import Kingfisher

struct MenuHorizontalItemView: View {
    
    var product: Product
    
    var body: some View {
        
        HStack{
            KFImage(URL(string: product.imageURL))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                
            
            Spacer()
            
            VStack(alignment: .leading){
                Text(product.name)
                    .font(.caption)
                    .foregroundColor(Color(red: 83/255, green: 124/255, blue: 209/255))
                
                Spacer()
                
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
                
                Spacer()
                
            }
            Spacer()
        }
        .padding()
        
    }
}

//struct MenuHorizontalItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuHorizontalItemView()
//    }
//}
