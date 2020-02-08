//
//  MenuTableCellTableViewCell.swift
//  CoinPort
//
//  Created by Kamal Maged on 2019-12-29.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

import UIKit

class MenuTableCell: UITableViewCell {


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
