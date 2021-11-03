//
//  ViewController.swift
//  NetworkApp1
//
//  Created by Giuseppe Mauri on 03/11/21.
//

import UIKit

class MainViewController: UIViewController {
    let dataManger = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension MainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataManger.numberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataManger.getItem(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedNewsTableViewCell.cellIdentify, for: indexPath) as! FeedNewsTableViewCell
        cell.configure(indexPath: indexPath, item: item)
        return cell
    }
    
    
}

extension MainViewController: UITableViewDelegate{
    
}
