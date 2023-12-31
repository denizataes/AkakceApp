//
//  PriceView.swift
//  AkakceApp
//
//  Created by Deniz Ata Eş on 13.06.2023.
//

import SwiftUI

///Uses for the price labels
struct PriceView: View {
    var price: Double
    var fontSize: CGFloat
    
    var body: some View {
        HStack(spacing: 2) {
            Text("\(String(format: "%.2f", price))")
                .font(.system(size: fontSize, weight: .bold))
            Text(",00 TL")
                .font(.system(size: 9))
        }
        .foregroundColor(.primary)
    }
}
