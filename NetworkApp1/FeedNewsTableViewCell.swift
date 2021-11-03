//
//  FeedNewsTableViewCell.swift
//  NetworkApp1
//
//  Created by Giuseppe Mauri on 03/11/21.
//

import UIKit

class FeedNewsTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var imgFeed: UIImageView!
    static var cellIdentify: String {
        return "tableNewsCell"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        lblTitle.text = ""
        lblSummary.text = ""
        lblAuthor.text = ""
        imgFeed.image = nil
    }
    
    func configure(indexPath: IndexPath, item:FeedModelItem?){
        if let item = item {
        lblTitle.text = item.title
        lblSummary.text = item.summary
        lblAuthor.text = item.author?.name
        if let imageUrl = item.image {
            DispatchQueue.global().async {
                if let url = URL(string: imageUrl) {
                    let data = try? Data(contentsOf: url)
                    if let imageData = data {
                        DispatchQueue.main.async {
                            self.imgFeed.image = UIImage(data: imageData)
                            print(imageUrl)
                        }
                    }
                }
            }
        }
    }
    }
}


