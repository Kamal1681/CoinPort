//
//  OfferTableCellDelegate.swift
//  CoinPort
//
//  Created by Kamal Maged on 2020-01-05.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import Foundation
import Firebase

protocol OfferTableCellDelegate {
    func getDistance(offerLocation: GeoPoint, completion: @escaping (String) -> Void)
    func getUser(profilePicture: URL, completion: @escaping (UIImage) -> Void)
}
