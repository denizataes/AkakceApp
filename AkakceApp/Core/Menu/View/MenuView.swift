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
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        
        ScrollView {
            
            horizontalView
            
            verticalView
            
        }
        .overlay(content: {
            if !viewModel.loaded {
                CustomLoadingView()
            }
        })
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Image("akakce")
                        .resizable()
                        .frame(width: 120, height: 32)
                        .cornerRadius(5)
                  
                    
                    
                }
                
            }
        }
        
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Image(systemName: "line.3.horizontal")
                        .resizable()
                        .frame(width: 22, height: 20)
                        .foregroundColor(Color(hex: "237EC4"))
                        
                }
                
            }
        }
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.gray)
                        
                }
                
            }
        }
        
        
        
        .alert(viewModel.errorMessage, isPresented: $viewModel.showError) {
        }
    }
    
    // MARK: HorizontalView
    var horizontalView: some View{
        
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
        
    }
    
    // MARK: VerticalView
    var verticalView: some View{
        ZStack {
            Color.gray.opacity(0.08)
                .ignoresSafeArea()
            
            ScrollViewReader { scrollViewProxy in
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.itemList?.result.products ?? []) { product in
                        VStack {
                            NavigationLink(destination: DetailView(url: "\(Config.detailUrl)\(product.code)")) {
                                MenuVerticalItemView(product: product)
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




struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

