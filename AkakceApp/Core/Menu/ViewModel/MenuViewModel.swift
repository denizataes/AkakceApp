//
//  MenuViewModel.swift
//  AkakceApp
//
//  Created by Deniz Ata Eş on 12.06.2023.
//

import Foundation

class MenuViewModel: ObservableObject{
    
    @Published var itemList: Item?
    let service = AkakceService()
    
    init(){
        fetchItems()
    }
    func fetchItems(){
        service.fetchItem { [weak self] results in
            guard let strongSelf = self else { return }
            
            switch(results){
            case .success(let items):
                DispatchQueue.main.async {
                    strongSelf.itemList = items
                }
        
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    func fetchNextPage(nextPageURL: String){
        service.fetchItem(url: nextPageURL) { [weak self] results in
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
                            }
                        }
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
        
    }
}
