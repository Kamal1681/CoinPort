//
//  DigitalCurrencyTableCell.swift
//  CoinPort
//
//  Created by Kamal Maged on 2020-01-26.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import UIKit

class DigitalCurrencyTableCell: UITableViewCell {
    
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var abbreviationLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    var delegate: DigitalCurrencyTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .blue
        delegate?.setCurrency(digtalCurrency: currencyLabel.text!)
    }

}
