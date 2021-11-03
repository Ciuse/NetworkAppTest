//
//  DataManager.swift
//  NetworkApp1
//
//  Created by Giuseppe Mauri on 03/11/21.
//

import Foundation

class DataManager {
    fileprivate var dataManager = NetwkorkMisc()
    fileprivate var items: [FeedModelItem]?
    
    func fetch () {
        dataManager.getDataFrom(dataUrl: URL(string: "https://feeds.npr.org/1004/feed.json")!) { result in
            switch result {
            case .success(let data):
                self.items = data?.items
                
            case .failure(let error):
                switch error {
                case .httpStatusNotValid:
                    print("errore http")
                    
                case .noData:
                    print("error noData")
                    
                case .jsonError(let e):
                    print("error:\(e)")
                }
            }
        }
    }
    
    func numberOfItems() -> Int? {
        items?.count
    }
    
    func getItem(at index: IndexPath) -> FeedModelItem? {
        items?[index.item]
    }
}
