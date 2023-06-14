//
//  StorageButtonView.swift
//  AkakceApp
//
//  Created by Deniz Ata Eş on 13.06.2023.
//

import SwiftUI

///Uses for the storage buttons
struct StorageButtonView: View {
    var storage: String
    var body: some View {
        Button {
            
        } label: {
            Text("\(storage)")
                .font(.caption2)
                .foregroundColor(.primary)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.primary, lineWidth: 1)
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
