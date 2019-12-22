//
//  User.swift
//  CoinPort
//
//  Created by Kamal Maged on 2019-10-07.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

import Foundation
import UIKit

class User {
    var userID: String?
    var name: String?
    var photo: UIImageView?
    var offersArray = [Offer?]()
    
    
    
    init(userID: String, name: String, photo: UIImageView) {
        self.userID = userID
        self.name = name
        self.photo = photo
        
    }
    
}

