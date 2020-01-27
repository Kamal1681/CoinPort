//
//  CurrencyOptions.swift
//  CoinPort
//
//  Created by Kamal Maged on 2020-01-22.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import Foundation
import UIKit

enum DigitalCurrencyOptions: Int, CustomStringConvertible {
    
    case bitcoin
    case ripple
    case ethereum
    case eos
    case litecoin
    case bitcoinCash
    case stellar
    case tron

    
    
    var description: String {
        switch self {
            
        case .bitcoin: return "Bitcoin"
        case .ripple: return "Ripple"
        case .ethereum: return "Ethereum"
        case .eos: return "EOS"
        case .litecoin: return "Litecoin"
        case .bitcoinCash: return "Bitcoin Cash"
        case .stellar: return "Stellar"
        case .tron: return "Tron"
        }
    }
    
    var abbreviation: String {
        switch self {
            
        case .bitcoin: return "BTC"
        case .ripple: return "XRP"
        case .ethereum: return "BTH"
        case .eos: return "EOS"
        case .litecoin: return "LTC"
        case .bitcoinCash: return "BCH"
        case .stellar: return "XLM"
        case .tron: return "TRX"
        }
    }
    
    var image: UIImage {
        switch self {
            
        case .bitcoin:
            return UIImage(systemName: "person")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
        case .ripple:
            return UIImage(systemName: "plus")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
        case .ethereum:
            return UIImage(systemName: "bolt.horizontal.circle.fill")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
        case .eos:
            return UIImage(systemName: "heart")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
        case .litecoin:
            return UIImage(systemName: "wifi")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
        case .bitcoinCash:
            return UIImage(systemName: "escape")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
        case .stellar:
            return UIImage(systemName: "questionmark.circle.fill")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
        case .tron:
            return UIImage(systemName: "paperplane")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
        }
    }
}
