//
//  ResultTableViewCell.swift
//  Hive-iOS-Assignment
//
//  Created by MD Faizan on 02/09/23.
//

import UIKit
import SDWebImage

final class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak private var resultImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var subtitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        resultImageView.layer.cornerRadius = resultImageView.frame.size.width/2
        resultImageView.clipsToBounds = true
    }
    
    func configureCell(_ searchItem: WikipediaSearchResult) {
        titleLabel.text = searchItem.title
        subtitleLabel.text = searchItem.extract
        
        let imageUrl = URL(string: searchItem.imageUrlString ?? "")
        let placeholder = UIImage(named: Constants.placeholder)

        resultImageView.sd_setImage(with: imageUrl,
                                    placeholderImage: placeholder)
        
//        resultImageView.isHidden =  searchItem.imageUrlString == nil
    }
    
}
