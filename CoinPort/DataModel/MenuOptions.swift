//
//  MenuOptions.swift
//  CoinPort
//
//  Created by Kamal Maged on 2019-12-29.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

import Foundation
import UIKit

enum MenuOptions: Int, CustomStringConvertible {
    
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
            return UIImage(systemName: "person")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
        case .addNewOffer:
            return UIImage(systemName: "plus")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
        case .inbox:
            return UIImage(systemName: "bolt.horizontal.circle.fill")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
        case .favorites:
            return UIImage(systemName: "heart")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
        case .arabBitNews:
            return UIImage(systemName: "wifi")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
        case .logout:
            return UIImage(systemName: "escape")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
        case .repeatTutorial:
            return UIImage(systemName: "questionmark.circle.fill")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
        case .tellAboutUs:
            return UIImage(systemName: "paperplane")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
        case .rateApp:
            return UIImage(systemName: "hand.thumbsup")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
        case .contactUs:
            return UIImage(systemName: "envelope")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
        }
    }
}
