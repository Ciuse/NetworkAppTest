//
//  FeedNewsTableViewCell.swift
//  NetworkApp1
//
//  Created by Giuseppe Mauri on 03/11/21.
//

import UIKit

class FeedNewsTableViewCell: UITableViewCell {
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblSummary: UILabel!
    @IBOutlet private weak var lblAuthor: UILabel!
    @IBOutlet private weak var imgFeed: UIImageView!
    
    static var cellIdentify: String {
        return "tableNewsCell"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imgFeed.image = nil
    }
    
    func configure(indexPath: IndexPath, item:FeedModelItem?) {
        lblTitle.text = item?.title
        lblSummary.text = item?.summary
        lblAuthor.text = item?.author?.name
        
        if let imageUrl = item?.image, let url = URL(string: imageUrl) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.imgFeed.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}


