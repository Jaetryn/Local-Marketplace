//
//  OwnedItemTableViewCell.swift
//  LocalMarketplace
//
//  Created by Ben Bellis on 4/30/19.
//  Copyright © 2019 John Trinh. All rights reserved.
//

import UIKit

class OwnedItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
