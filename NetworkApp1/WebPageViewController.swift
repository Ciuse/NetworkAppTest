//
//  WebPageViewController.swift
//  NetworkApp1
//
//  Created by Giuseppe Mauri on 03/11/21.
//

import UIKit
import WebKit

class WebPageViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet private weak var wkFeedNews: WKWebView!
    
    var urlFeedNews: String?
    static var viewControllerIdentify: String {
        return "webPageViewControllerId"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wkFeedNews.navigationDelegate = self
        
        if let urlFeedNews = urlFeedNews {
            let url = URL(string: urlFeedNews)!
            let urlRequest = URLRequest(url: url)
            
            wkFeedNews.load(urlRequest)
            
        } else {
            showAlert(allertTitle: "Page not found", allertMessage: "The url value: \(urlFeedNews ?? "nil") is not correct")
        }
    }

    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated  {
            if let url = navigationAction.request.url,
                let host = url.host, !host.hasPrefix(urlFeedNews!),
                UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
                print(url)
                print("Redirected to browser. No need to open it locally")
                decisionHandler(.cancel)
            } else {
                print("Open it locally")
                decisionHandler(.allow)
            }
        } else {
            print("not a user click")
            decisionHandler(.allow)
        }
    }
}

extension WebPageViewController {
    private func showAlert(allertTitle tile: String, allertMessage message: String) {
        let alertController = UIAlertController(title: tile, message: message, preferredStyle:.alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
