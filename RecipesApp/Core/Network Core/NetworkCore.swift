//
//  NetworkCore.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 31.03.2022.
//

import Foundation

protocol Responsable: Codable {
}

enum NetworkError: Error {
    case invalidURL
    case responseDecodingError
}

protocol NetworkCoreProtocol {
    func request<Res: Responsable>(metadata: String, comletion: @escaping (Result<Res, NetworkError>) -> Void)
}

final class NetworkCore {
    static let shared: NetworkCoreProtocol = NetworkCore()
    
    private let key = "fee63bc6daef42728684e8d1a4f5dc51"
    private let urlString = "https://api.spoonacular.com"
    private let jsonDecoder = JSONDecoder()
}

extension NetworkCore: NetworkCoreProtocol {
    func request<Res: Responsable>(metadata: String, comletion: @escaping (Result<Res, NetworkError>) -> Void) {
        let urlRequest = URL(string: "\(urlString)/\(metadata)&apiKey=\(key)")

//        print("\(urlString)/\(metadata)&apiKey=\(key)")
        
        guard let url = urlRequest else {
            comletion(.failure(NetworkError.invalidURL))
            return
        }

        let dataTask = URLSession
            .shared
            .dataTask(with: url, completionHandler: { (data, response, error) in
                if let data = data,
                   (response as? HTTPURLResponse)?.statusCode == 200,
                   error == nil {
                    self.handleSuccsesDataResponse(data, comletion: comletion)
                }
            })
        dataTask.resume()
    }
}

extension NetworkCore {
    private func handleSuccsesDataResponse<Res: Responsable>(_ data: Data, comletion: (Result<Res, NetworkError>) -> Void) {
        do {
            comletion(.success(try decodeData(data: data)))
        } catch {
            comletion(.failure(.responseDecodingError))
        }
    }
    
    private func decodeData<Res: Responsable>(data: Data) throws -> Res {
        let response = try jsonDecoder.decode(Res.self, from: data)
        return response
    }
}
