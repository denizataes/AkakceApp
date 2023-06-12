//
//  MenuView.swift
//  AkakceApp
//
//  Created by Deniz Ata Eş on 12.06.2023.
//

import SwiftUI
import Kingfisher

struct MenuView: View {
    @ObservedObject var viewModel = MenuViewModel()
    @State private var currentIndex: Int? = nil
    
    var body: some View {
        ScrollView {
            ScrollViewReader { scrollViewProxy in
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(viewModel.itemList?.result.products ?? []) { product in
                        VStack {
                            MenuItemView(product: product)
                        }
                        .frame(maxWidth: .infinity)
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        .cornerRadius(8)
                        .id(product.id) // Her ürüne benzersiz bir ID atayın
                        .onAppear {
                            // Son eleman göründüğünde currentIndex'i güncelleyin
                            if product.code == viewModel.itemList?.result.products.last?.code {
                                currentIndex = product.code
                            }
                        }
                    }
                }
                .padding()
                .onChange(of: currentIndex) { newValue in
                    if let currentIndex = newValue {
                        withAnimation {
                            scrollViewProxy.scrollTo(currentIndex, anchor: .bottom)
                            if let url = viewModel.itemList?.result.nextURL,
                               currentIndex == viewModel.itemList?.result.products.last?.code {
                                viewModel.fetchNextPage(nextPageURL: url)
                            }
                        }
                    }
                }

            }
        }
    }
}
struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
