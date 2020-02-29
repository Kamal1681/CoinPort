//
//  CountryListViewControllerDelegate.swift
//  CoinPort
//
//  Created by Kamal Maged on 2020-02-22.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import Foundation
import UIKit

protocol CurrencyListViewControllerDelegate {
    func setRealCurrencyAndFlag(realCurrency: String, flag: UIImage, currencyCode: String)
    func setAlpha()
}
