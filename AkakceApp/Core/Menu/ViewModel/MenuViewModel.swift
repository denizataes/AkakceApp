//
//  MenuViewModel.swift
//  AkakceApp
//
//  Created by Deniz Ata Eş on 12.06.2023.
//

import Foundation

class MenuViewModel: ObservableObject{
    
    // MARK: Properties
    @Published var itemList: Item?
    @Published var loaded: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    let service = AkakceService()
    
    init(){
        fetchItems()
    }
    
    //MARK: Functions
    ///This method works when the main screen is loaded and pulls data from the API.
    func fetchItems(){
        
        let url = URL(string: Config.apiUrl)!
        service.fetchData(for: Item.self, from: url) {
            [weak self] results in
            guard let strongSelf = self else { return }
            
            switch(results){
            case .success(let items):
                DispatchQueue.main.async {
                    strongSelf.itemList = items
                    strongSelf.loaded = true
                }
                break
        
            case .failure(let error):
                strongSelf.showError = true;
                strongSelf.errorMessage = "Hata oluştu. \nHata Detayı:  \(error.localizedDescription)"
                strongSelf.loaded = true
                break
            }
        }
    }
    
    ///This method works when the last item appears on the screen and pulls data for the next page.
    func fetchNextPage(nextPageURL: String){
        loaded = false
        
        if nextPageURL.isEmpty{
            return
        }
            
        service.fetchData(for: Item.self, from: URL(string: nextPageURL)!) {[weak self] results in
            guard let strongSelf = self else { return }
            
            switch(results){
            case .success(let items):
                        DispatchQueue.main.async {
                            if let currentItemList = strongSelf.itemList {
                                var updatedProducts = currentItemList.result.products
                                var updatedHorizontalProducts = currentItemList.result.horizontalProducts
                                updatedProducts.append(contentsOf: items.result.products)
                                
                                if let horizontalProduct = items.result.horizontalProducts{
                                    updatedHorizontalProducts?.append(contentsOf: horizontalProduct)
                                }
                                
                                strongSelf.itemList = Item(result: AkakceResult(nextURL: items.result.nextURL,
                                                                          horizontalProducts: updatedHorizontalProducts,
                                                                          products: updatedProducts))
                                strongSelf.loaded = true
                            }
                        }
                break
            case .failure(let error):
                strongSelf.showError = true;
                strongSelf.errorMessage = "Hata oluştu. \nHata Detayı:  \(error.localizedDescription)"
                strongSelf.loaded = true
            }
        }
        
    }
}
