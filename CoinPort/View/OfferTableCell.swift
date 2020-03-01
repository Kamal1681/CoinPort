//
//  OfferTableCell.swift
//  CoinPort
//
//  Created by Kamal Maged on 2020-02-06.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import UIKit
import FlagKit
import Firebase
import GoogleMaps

class OfferTableCell: UITableViewCell {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userFlag: UIImageView!
    @IBOutlet weak var digitalCurrencyLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var exchangeAmountLabel: UILabel!
    @IBOutlet weak var exchangeRateLabel: UILabel!
    @IBOutlet weak var isFavorite: UIButton!
    @IBOutlet weak var numberOfViewsLabel: UILabel!
    @IBOutlet weak var offerRequestLabel: UILabel!
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    
    @IBOutlet weak var offerStatusLabel: UILabel!
    
    @IBOutlet weak var mapButton: UIButton!
    var countryCode: String?
    var delegate: OfferTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(offer: Offer) {
        userLabel.text = offer.user
        countryCode = delegate?.getCountryCode(userCountry: offer.userCountry)
        if let countryCode = countryCode {
            userFlag.image = UIImage(named: countryCode, in: FlagKit.assetBundle, with: nil)
        }
        digitalCurrencyLabel.text = offer.digitalCurrency
        exchangeRateLabel.text = offer.exchangeRate
        exchangeAmountLabel.text = String(offer.exchangeAmount)
        numberOfViewsLabel.text = String(offer.numberOfViews)
        offerStatusLabel.text = offer.offerStatus.map { $0.rawValue }
        offerRequestLabel.text = offer.offerRequest.map { $0.rawValue }
        
        if let offerLocation = offer.offerLocation {
            delegate?.getDistance(offerLocation: offerLocation, completion: { (distance) in
                offer.distance = distance
                self.distanceLabel.text = offer.distance
            })
        }
        if let profilePictureURL = offer.profilePictureURL {
            delegate?.getUser(profilePicture: profilePictureURL, completion: { (photo) in
                self.profilePicture.image = photo
                self.profilePicture.layer.borderWidth = 1.0
                self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
                self.profilePicture.layer.borderColor = UIColor.lightGray.cgColor
                self.profilePicture.layer.masksToBounds = true
                self.profilePicture.clipsToBounds = true
            })
        }
    }
    
    
    @IBAction func isFavoriteButtonPressed(_ sender: Any) {
        print("favorite")
        
    }
    
    @IBAction func mapButtonPressed(_ sender: Any) {
        print("map")
    }
    
}
