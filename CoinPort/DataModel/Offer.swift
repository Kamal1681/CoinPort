//
//  Offer.swift
//  CoinPort
//
//  Created by Kamal Maged on 2019-09-18.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

import Foundation
import GoogleMaps
import Firebase

enum OfferRequest: String {
    case ToBuy
    case ToSell
}

enum OfferStatus: String {
    case Expired
    case Active
}

class Offer {
    var digitalCurrency: String = ""
    var exchangeAmount = 0.0
    var exchangeRate: String = ""
    var realCurrency: String = ""
    var offerLocation: GeoPoint?
    var offerRequest: OfferRequest?
    var offerStatus: OfferStatus?
    var user: String = ""
    var userCountry: String = ""
    var distance: String = ""
    var numberOfViews = 0
    var review: Review?
    
}
