import Foundation

class DetailViewModel: ObservableObject {
    var url: String?
    let service = AkakceService()
    @Published var detail: ItemDetail?

    init(url: String) {
        self.url = url
        fetchItemDetail()
        print(url)
    }

    func fetchItemDetail() {
        if let urlString = url, let url = URL(string: urlString) {
            service.fetchData(for: ItemDetail.self, from: url) { result in
                switch result {
                case .success(let item):
                    DispatchQueue.main.async {
                        self.detail = item
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
