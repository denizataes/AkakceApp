//
//  StorageButtonView.swift
//  AkakceApp
//
//  Created by Deniz Ata Eş on 13.06.2023.
//

import SwiftUI

struct StorageButtonView: View {
    var storage: String
    var body: some View {
        Button {
            // Butona tıklanınca yapılacak işlem
        } label: {
            Text("\(storage)")
                .font(.caption2)
                .foregroundColor(.black)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.black, lineWidth: 1)
                )
                .cornerRadius(4)
        }
    }
}

struct StorageButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StorageButtonView(storage: "128")
    }
}
