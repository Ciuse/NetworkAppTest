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
        dataManger.fetchAndReload {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension MainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManger.numberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataManger.getItem(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedNewsTableViewCell.cellIdentify, for: indexPath) as! FeedNewsTableViewCell
        cell.configure(indexPath: indexPath, item: item)
        return cell
    }
}

extension MainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vcWebPage = storyboard.instantiateViewController(withIdentifier: "WebPageViewControllerId") as! WebPageViewController
        let navController = self.navigationController
        
        vcWebPage.urlFeedNews = dataManger.getItem(at: indexPath)?.url
        
        navController?.pushViewController(vcWebPage, animated: true)
    }
}


