//
//  DataManager.swift
//  NetworkApp1
//
//  Created by Giuseppe Mauri on 03/11/21.
//

import Foundation
import UIKit

class DataManager {
    fileprivate var networkManager = NetworkManager()
    fileprivate var items: [FeedModelItem]?
    private var envUrl: Bool = true
    private var callBackShowAllert: ((String, String)->Void)?
    private var urlString: String {
        if envUrl {
            return "https://feeds.npr.org/1004/feed.json"
        } else {
            return "https://feeds.npr.org/1005/feed.json"
        }
    }

    func fetch(completion: @escaping (MyError?) -> Void) {
        networkManager.getDataFrom(dataUrl: URL(string: urlString)!) { result in
            switch result {
            case .success(let data):
                self.items = data?.items
                completion(nil)

            case .failure(let error):
                completion(error)
            }
        }
    }
    
    
//    switch error {
//    case .httpStatusNotValid:
//        self.callBackShowAllert?("Error Http Status Not Valid", error.localizedDescription)
//
//    case .noData:
//        self.callBackShowAllert?("Error No Data", error.localizedDescription)
//
//    case .jsonError(let e):
//        self.callBackShowAllert?("Error", e)
//    }
//
    
    func numberOfItems() -> Int {
        items?.count ?? 0
    }
    
    func getItem(at index: IndexPath) -> FeedModelItem? {
        if index.row < 0 || index.row >= numberOfItems() {
            return nil
        }
        
        return items?[index.row]
    }
}
