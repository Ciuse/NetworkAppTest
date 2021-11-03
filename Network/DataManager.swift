//
//  DataManager.swift
//  NetworkApp1
//
//  Created by Giuseppe Mauri on 03/11/21.
//

import Foundation
import UIKit

class DataManager {
    fileprivate var dataManager = NetworkManager()
    fileprivate var items: [FeedModelItem]?
    private var callBackShowAllert: ((String, String)->Void)?

    func fetchAndReload(completion: @escaping () -> Void) {
        dataManager.getDataFrom(dataUrl: URL(string: "https://feeds.npr.org/1004/feed.json")!) { result in
            switch result {
            case .success(let data):
                self.items = data?.items
                
            case .failure(let error):
                switch error {
                case .httpStatusNotValid:
                    self.callBackShowAllert?("Error Http Status Not Valid", error.localizedDescription)
                    
                case .noData:
                    self.callBackShowAllert?("Error No Data", error.localizedDescription)
                    
                case .jsonError(let e):
                    self.callBackShowAllert?("Error", e)
                }
            }
            completion()
        }
    }
    
    func configure(callBack: @escaping (String, String)->Void) {
        callBackShowAllert = callBack
    }
    
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
