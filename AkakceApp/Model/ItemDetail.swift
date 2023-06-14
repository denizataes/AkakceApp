import Foundation

// MARK: - ItemDetail
struct ItemDetail: Codable {
    let result: ResultDetail
}

// MARK: - ResultDetail
struct ResultDetail: Codable, Identifiable {
    let id = UUID()
    let mkName, productName, badge: String
    let rating: Double
    let imageURL: String
    let storageOptions: [String]
    let countOfPrices, price: Int
    let freeShipping: Bool
    let lastUpdate: String

    enum CodingKeys: String, CodingKey {
        case mkName, productName, badge, rating
        case imageURL = "imageUrl"
        case storageOptions, countOfPrices, price, freeShipping, lastUpdate
    }
}
