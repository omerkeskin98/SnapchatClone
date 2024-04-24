//
//  FeedCell.swift
//  SnapchatClone
//
//  Created by Omer Keskin on 24.04.2024.
//

import Foundation
import UIKit

class FeedCell: UITableViewCell {

    
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var feedUsernameLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupImageViewConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    func setupImageViewConstraints() {
        // Aspect ratio constraints
        feedImageView.translatesAutoresizingMaskIntoConstraints = false
        feedImageView.contentMode = .scaleAspectFit
        
        // İmageView'in genişlik ve yükseklik constraint'leri
        let widthConstraint = NSLayoutConstraint(item: feedImageView!, attribute: .width, relatedBy: .equal, toItem: contentView, attribute: .width, multiplier: 1.0, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: feedImageView!, attribute: .height, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 1, constant: 0)
        
        // Yatayda ortalanma constraint'i
        let centerXConstraint = NSLayoutConstraint(item: feedImageView!, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1.1, constant: 0)
        
        // Constraints'u aktifleştir
        NSLayoutConstraint.activate([widthConstraint, heightConstraint, centerXConstraint])
    }
    

}
