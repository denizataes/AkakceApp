import Foundation

class DetailViewModel: ObservableObject {
    
    // MARK: Properties
    var url: String?
    let service = AkakceService()
    
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @Published var detail: ItemDetail?

    init(url: String) {
        self.url = url
        fetchItemDetail()
    }
    
    //MARK: Functions
    ///This method works when the item detail is loaded and pulls data from the API.
    func fetchItemDetail() {
        if let urlString = url, let url = URL(string: urlString) {
            service.fetchData(for: ItemDetail.self, from: url) {[weak self] result in
                guard let strongSelf = self else {return}
                switch result {
                case .success(let item):
                    DispatchQueue.main.async {
                        strongSelf.detail = item
                    }
                case .failure(let error):
                    strongSelf.showError = true;
                    strongSelf.errorMessage = "Hata oluştu. \nHata Detayı:  \(error.localizedDescription)"
                }
            }
        }
    }
}
