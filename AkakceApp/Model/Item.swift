import Foundation

// MARK: - Item
struct Item: Codable {
    var result: AkakceResult
}

// MARK: - Result
struct AkakceResult: Codable {
    var nextURL: String?
    let horizontalProducts: [Product]?
    let products: [Product]

    enum CodingKeys: String, CodingKey {
        case nextURL = "nextUrl"
        case horizontalProducts, products
    }
}

// MARK: - Product
struct Product: Codable, Identifiable {
    let id = UUID()
    let code: Int
    let imageURL: String
    let name: String
    let dropRatio: Double?
    let price: Double
    let countOfPrices, followCount: Int?

    enum CodingKeys: String, CodingKey {
        case code
        case imageURL = "imageUrl"
        case name, dropRatio, price, countOfPrices, followCount
    }
}
