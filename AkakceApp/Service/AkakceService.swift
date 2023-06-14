//
//  AkakceService.swift
//  AkakceApp
//
//  Created by Deniz Ata Eş on 12.06.2023.
//

import Foundation

struct AkakceService{
    
    static let shared = AkakceService()
    ///This generic method makes a request based on the url information entered. Converts and returns the result of the request to the class specified in the parameter.
    func fetchData<T: Decodable>(for type: T.Type, from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                let error = NSError(domain: "Empty response", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
}
