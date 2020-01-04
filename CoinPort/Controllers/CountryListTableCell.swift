//
//  CountryListTableCell.swift
//  CoinPort
//
//  Created by Kamal Maged on 2020-01-03.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import UIKit

class CountryListTableCell: UITableViewCell {
    @IBOutlet weak var itemLabel: UILabel!
    
    @IBOutlet weak var itemImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
