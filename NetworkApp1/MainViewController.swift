//
//  ViewController.swift
//  NetworkApp1
//
//  Created by Giuseppe Mauri on 03/11/21.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    let dataManger = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        dataManger.configure { title, message in
        //            self.showAlert(allertTitle: title, allertMessage: message)
        //        }
        
        dataManger.fetch { error in
            if error == nil{
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                self.handleError(error: error!)
            }
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManger.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataManger.getItem(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedNewsTableViewCell.cellIdentify, for: indexPath) as! FeedNewsTableViewCell
        cell.configure(indexPath: indexPath, item: item)
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.delegate?.tableView?(tableView, didDeselectRowAt: indexPath)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vcWebPage = storyboard.instantiateViewController(withIdentifier: WebPageViewController.viewControllerIdentify) as! WebPageViewController
        let navController = self.navigationController
        
        vcWebPage.urlFeedNews = dataManger.getItem(at: indexPath)?.url
        
        navController?.pushViewController(vcWebPage, animated: true)
    }
}

extension MainViewController {
    
    private func handleError (error: MyError) {
        switch error {
           case .httpStatusNotValid:
            showAlert(allertTitle: "Error Http Status Not Valid", allertMessage: error.localizedDescription)
       
           case .noData:
            showAlert(allertTitle: "Error No Data", allertMessage: error.localizedDescription)
       
           case .jsonError(let e):
            showAlert(allertTitle: "Error", allertMessage: e)
           }
    }
    
    private func showAlert(allertTitle tile: String, allertMessage message: String) {
        DispatchQueue.main.async{
            let alertController = UIAlertController(title: tile, message: message, preferredStyle:.alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}


