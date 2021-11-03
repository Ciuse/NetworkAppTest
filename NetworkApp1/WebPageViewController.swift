//
//  WebPageViewController.swift
//  NetworkApp1
//
//  Created by Giuseppe Mauri on 03/11/21.
//

import UIKit
import WebKit

class WebPageViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var wkFeedNews: WKWebView!
    var urlFeedNews: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wkFeedNews.navigationDelegate = self
        
        if let urlFeedNews = urlFeedNews {
            let url = URL(string: urlFeedNews)!
            let urlRequest = URLRequest(url: url)
            wkFeedNews.load(urlRequest)
        }
    }

}
