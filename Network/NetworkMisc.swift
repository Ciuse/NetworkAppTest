//
//  NetworkMisc.swift
//  NetworkApp1
//
//  Created by Giuseppe Mauri on 03/11/21.
//

import Foundation

enum MyError: Error {
    case httpStatusNotValid
    case noData
    case jsonError(value: String)
}

struct FeedModel: Decodable {
    let items: [FeedModelItem]
}

struct FeedModelAuthor: Decodable {
    let name: String?
}

struct FeedModelItem: Decodable {
    let url: String?
    let title: String?
    let summary: String?
    let image: String?
    let author: FeedModelAuthor?
}

class NetwkorkMisc {
    func getDataFrom(dataUrl url: URL, completion: @escaping (Result<FeedModel?, MyError>) -> Void) {
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            let response = response as? HTTPURLResponse
            if response?.statusCode == 200 {
                guard let data = data else {
                    completion(.failure(MyError.noData))
                    return
                }
                
                do {
                    let feedModel = try JSONDecoder().decode(FeedModel.self, from: data)
                    completion(.success(feedModel))
                } catch let e {
                    completion(.failure(MyError.jsonError(value: e.localizedDescription)))
                    return
                }
                
            } else {
                completion(.failure(MyError.httpStatusNotValid))
            }
        }
        task.resume()
    }
}

