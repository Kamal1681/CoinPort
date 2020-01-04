//
//  CountryListViewController.swift
//  CoinPort
//
//  Created by Kamal Maged on 2020-01-02.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import UIKit
import FlagKit

class CountryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var currencies = [String]()
    var flags = [UIImage]()
    var tempCurrencies = [String]()

    var reuseIdentifier = "Country List Table Cell"
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var currencyTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listCountriesAndCurrencies()
        
        currencyTableView.dataSource = self
        currencyTableView.delegate = self
        currencyTableView.separatorStyle = .none

        searchBar.delegate = self
    
    }

        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        currencies.removeAll()
        flags.removeAll()
        
        if searchBar.text?.count != 0 {
            for currency in tempCurrencies {
                if let searchText = searchBar.text {
                    let range = currency.lowercased().range(of: searchText, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {
                        currencies.append(currency)
                        flags.append(UIImage(named: currency, in: FlagKit.assetBundle, with: nil) ?? UIImage())
                    }
                }
            }
        } else {
            for currency in tempCurrencies {
                currencies.append(currency)
                flags.append(UIImage(named: currency, in: FlagKit.assetBundle, with: nil) ?? UIImage())
            }
        }
        currencyTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = currencyTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CountryListTableCell
        
        cell.itemLabel.text = currencies[indexPath.row]
        cell.itemImage.image = flags[indexPath.row]
        
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func listCountriesAndCurrencies() {
        let localeIds = Locale.availableIdentifiers
        var countryCurrency = [String: String]()
        for localeId in localeIds {
            let locale = Locale(identifier: localeId)

            if let country = locale.regionCode, country.count == 2 {
                if let currency = locale.currencyCode {
                    let countryText = locale.localizedString(forRegionCode: country)

                    if !countryText!.isContiguousUTF8 {
                        continue
                    }

                    let currencyText = locale.localizedString(forCurrencyCode: currency)
                    if !currencyText!.isContiguousUTF8 {
                       continue
                    }
                    countryCurrency[countryText!] = currencyText
                    currencies.append(currencyText!)
                    tempCurrencies.append(currencyText!)
                    flags.append(UIImage(named: country, in: FlagKit.assetBundle, with: nil) ?? UIImage())

                    currencyTableView.reloadData()
                }
            }
        }
    }
    
}
