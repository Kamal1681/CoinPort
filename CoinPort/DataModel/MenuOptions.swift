//
//  MenuOptions.swift
//  CoinPort
//
//  Created by Kamal Maged on 2019-12-29.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

import Foundation
import UIKit

enum MenuOption: Int, CustomStringConvertible {
    
    case myProfile
    case addNewOffer
    case inbox
    case favorites
    case arabBitNews
    case logout
    case repeatTutorial
    case tellAboutUs
    case rateApp
    case contactUs
    
    
    var description: String {
        switch self {
            
        case .myProfile: return "My Profile"
        case .addNewOffer: return "Add New Offer"
        case .inbox: return "Inbox"
        case .favorites: return "Favorites"
        case .arabBitNews: return "ArabBit News"
        case .logout: return "Logout"
        case .repeatTutorial: return "Repeat Tutorial"
        case .tellAboutUs: return "Tell About Us"
        case .rateApp: return "Rate App"
        case .contactUs: return "Contact Us"
        }
    }
    
    var image: UIImage {
        switch self {
            
        case .myProfile:
            return UIImage(named: "ic_person_outline_white_2x") ?? UIImage()
        case .addNewOffer:
            return UIImage(named: "ic_person_outline_white_2x") ?? UIImage()
        case .inbox:
            return UIImage(named: "ic_person_outline_white_2x") ?? UIImage()
        case .favorites:
            return UIImage(named: "ic_person_outline_white_2x") ?? UIImage()
        case .arabBitNews:
            return UIImage(named: "ic_person_outline_white_2x") ?? UIImage()
        case .logout:
            return UIImage(named: "ic_person_outline_white_2x") ?? UIImage()
        case .repeatTutorial:
            return UIImage(named: "ic_person_outline_white_2x") ?? UIImage()
        case .tellAboutUs:
            return UIImage(named: "ic_person_outline_white_2x") ?? UIImage()
        case .rateApp:
            return UIImage(named: "ic_person_outline_white_2x") ?? UIImage()
        case .contactUs:
            return UIImage(named: "ic_person_outline_white_2x") ?? UIImage()
        }
    }
}
