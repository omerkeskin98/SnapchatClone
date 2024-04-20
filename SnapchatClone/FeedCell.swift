//
//  FeedCell.swift
//  SnapchatClone
//
//  Created by Omer Keskin on 18.04.2024.
//

import UIKit

class FeedCell: UITableViewCell {

    
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var feedUsernameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
