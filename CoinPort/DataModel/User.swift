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
    var email: String?
    var photo: UIImage?
    var offersArray = [Offer?]()
    
    
    
    init(email: String, name: String, photo: UIImage) {
        
        self.email = email
        self.name = name
        self.photo = photo
    }
    
}

