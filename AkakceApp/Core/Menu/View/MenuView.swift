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
    @State private var currentIndexHorizontal: Int? = 1
    
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        
        ScrollView {
            VStack {
            
                TabView{
                    ForEach(viewModel.itemList?.result.horizontalProducts ?? []) { product in
                        NavigationLink {
                            DetailView(url: "\(Config.detailUrl)\(product.code)")
                        } label: {
                            MenuHorizontalItemView(product: product)
                                .foregroundColor(.black)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .frame(height: 200)
                .onAppear {
                    UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color(hex: "237EC4"))
                }
                .id(UUID())
                
                
                
                ZStack {
                    Color.gray.opacity(0.08)
                        .ignoresSafeArea()
                    
                    ScrollViewReader { scrollViewProxy in
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(viewModel.itemList?.result.products ?? []) { product in
                                VStack {
                                    NavigationLink(destination: DetailView(url: "\(Config.detailUrl)\(product.code)")) {
                                        MenuItemView(product: product)
                                    }
                                }
                                .foregroundColor(.black)
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
        .overlay(content: {
            if !viewModel.loaded {
                CustomLoadingView()
            }
        })
        .navigationBarTitle("Akakçe'm🔥")
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
