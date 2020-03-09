//
//  CountryListViewController.swift
//  CoinPort
//
//  Created by Kamal Maged on 2020-01-02.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import UIKit
import FlagKit

class CurrencyListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    let codeToCountry = [
    "EUR" : "European Union",
    "USD" : "United States",
    "GBP" : "United Kingdom",
    "AED" : "United Arab Emirates",
    "AFN" : "Afghanistan",
    "ARS" : "Argentina",
    "AUD" : "Australia",
    "BBD" : "Barbados",
    "BDT" : "Bangladesh",
    "BGN" : "Bulgaria",
    "BHD" : "Bahrain",
    "BMD" : "Bermuda",
    "BND" : "Brunei",
    "BOB" : "Bolivia",
    "BRL" : "Brazil",
    "BTN" : "Bhutan",
    "BZD" : "Belize",
    "CAD" : "Canada",
    "CHF" : "Switzerland",
    "CLP" : "Chile",
    "CNY" : "Mainland China",
    "COP" : "Colombia",
    "CRC" : "Costa Rica",
    "CZK" : "Czech Republic",
    "DKK" : "Denmark",
    "DOP" : "Dominican Republic",
    "DZD" : "Algeria",
    "EGP" : "Egypt",
    "ETB" : "Ethiopia",
    "GEL" : "Georgia",
    "GHS" : "Ghana",
    "GMD" : "Gambia",
    "GYD" : "Guyana",
    "HKD" : "Hong Kong",
    "HRK" : "Croatia",
    "HUF" : "Hungary",
    "IDR" : "Indonesia",
    "INR" : "India",
    "IQD" : "Iraq",
    "IRR" : "Iran",
    "ISK" : "Iceland",
    "JMD" : "Jamaica",
    "JOD" : "Jordan",
    "JPY" : "Japan",
    "KES" : "Kenya",
    "KPW" : "North Korea",
    "KRW" : "South Korea",
    "KWD" : "Kuwait",
    "KYD" : "Cayman Islands",
    "KZT" : "Kazakhstan",
    "LAK" : "Laos",
    "LBP" : "Lebanon",
    "LKR" : "Sri Lanka",
    "LRD" : "Liberia",
    "LTL" : "Lithuania",
    "LYD" : "Libya",
    "MAD" : "Morocco",
    "MDL" : "Moldova",
    "MKD" : "Macedonia",
    "MNT" : "Mongolia",
    "MUR" : "Mauritius",
    "MWK" : "Malawi",
    "MXN" : "Mexico",
    "MYR" : "Malaysia",
    "MZN" : "Mozambique",
    "NAD" : "Namibia",
    "NGN" : "Nigeria",
    "NIO" : "Nicaragua",
    "NOK" : "Norway",
    "NPR" : "Nepal",
    "NZD" : "New Zealand",
    "OMR" : "Oman",
    "PEN" : "Peru",
    "PGK" : "Papua New Guinea",
    "PHP" : "Philippines",
    "PKR" : "Pakistan",
    "PLN" : "Poland",
    "PYG" : "Paraguay",
    "QAR" : "Qatar",
    "RON" : "Romania",
    "RSD" : "Serbia",
    "RUB" : "Russia",
    "SAR" : "Saudi Arabia",
    "SDG" : "Sudan",
    "SEK" : "Sweden",
    "SGD" : "Singapore",
    "SOS" : "Somalia",
    "SYP" : "Syria",
    "THB" : "Thailand",
    "TND" : "Tunisia",
    "TRY" : "Turkey",
    "TWD" : "Taiwan",
    "TZS" : "Tanzania",
    "UAH" : "Ukraine",
    "UGX" : "Uganda",
    "UYU" : "Uruguay",
    "VEB" : "Venezuela",
    "VND" : "Vietnam",
    "YER" : "Yemen",
    "ZAR" : "South Africa"]
    
    let currencyCodes = ["EUR", "USD", "GBP", "AED", "AFN", "ARS", "AUD", "BBD", "BDT", "BGN", "BHD", "BMD", "BND", "BOB", "BRL", "BTN", "BZD", "CAD", "CHF", "CLP", "CNY", "COP", "CRC", "CZK", "DKK", "DOP", "DZD", "EGP", "ETB", "GEL", "GHS", "GMD", "GYD", "HKD", "HRK", "HUF", "IDR", "INR", "IQD", "IRR", "ISK", "JMD", "JOD", "JPY", "KES", "KPW", "KRW", "KWD", "KYD", "KZT", "LAK", "LBP", "LKR", "LRD", "LTL", "LYD", "MAD", "MDL", "MKD", "MNT", "MUR", "MWK", "MXN", "MYR", "MZN", "NAD", "NGN", "NIO", "NOK", "NPR", "NZD", "OMR", "PEN", "PGK", "PHP", "PKR", "PLN", "PYG", "QAR", "RON", "RSD", "RUB", "SAR", "SDG", "SEK", "SGD", "SOS", "SYP", "THB", "TND", "TRY", "TWD", "TZS", "UAH", "UGX", "UYU", "VEB", "VND", "YER", "ZAR"]
    
    let countryCodes = ["EU", "US", "GB", "AE", "AF", "AR", "AU", "BB", "BD", "BG", "BH", "BM", "BN", "BO", "BR", "BT", "BZ", "CA", "CH", "CL", "CN", "CO", "CR", "CZ", "DK", "DO", "DZ", "EG", "ET", "GE", "GH", "GM", "GY", "HK", "HR", "HU", "ID", "IN", "IQ", "IR", "IS", "JM", "JO", "JP", "KE", "KP", "KR", "KW", "KY", "KZ", "LA", "LB", "LK", "LR", "LT", "LY", "MA", "MD", "MK", "MN", "MU", "MW", "MX", "MY", "MZ", "NA", "NG", "NI", "NO", "NP", "NZ", "OM", "PE", "PG", "PH", "PK", "PL", "PY", "QA", "RO", "RS", "RU", "SA", "SD", "SE", "SG", "SO", "SY", "TH", "TN", "TR", "TW", "TZ", "UA", "UG", "UY", "VE", "VN", "YE", "ZA"]
    
    let countries = ["European Union", "United States", "United Kingdom", "United Arab Emirates", "Afghanistan", "Argentina", "Australia", "Barbados", "Bangladesh", "Bulgaria", "Bahrain", "Bermuda", "Brunei", "Bolivia", "Brazil", "Bhutan", "Belize", "Canada", "Switzerland", "Chile", "China Mainland", "Colombia", "Costa Rica", "Czech Republic", "Denmark", "Dominican Republic", "Algeria", "Egypt", "Ethiopia", "Georgia", "Ghana", "Gambia", "Guyana", "Hong Kong", "Croatia", "Hungary", "Indonesia", "India", "Iraq", "Iran", "Iceland", "Jamaica", "Jordan", "Japan", "Kenya", "North Korea", "South Korea", "Kuwait", "Cayman Islands", "Kazakhstan", "Laos", "Lebanon", "Sri Lanka", "Liberia", "Lithuania", "Libya", "Morocco", "Moldova", "Macedonia", "Mongolia", "Mauritius", "Malawi", "Mexico", "Malaysia", "Mozambique", "Namibia", "Nigeria", "Nicaragua", "Norway", "Nepal", "New Zealand", "Oman", "Peru", "Papua New Guinea", "Philippines", "Pakistan", "Poland", "Paraguay", "Qatar", "Romania", "Serbia", "Russia", "Saudi Arabia", "Sudan", "Sweden", "Singapore", "Somalia", "Syria", "Thailand", "Tunisia", "Turkey", "Taiwan", "Tanzania", "Ukraine", "Uganda", "Uruguay", "Venezuela", "Vietnam", "Yemen", "South Africa"]
    
    var currencies = [String]()
    var flags = [UIImage]()
    var tempCurrencies = [String]()
    var tempFlags = [UIImage]()
    var countryDictionary = [String: String]()
    var currencyCodesDictionary = [String: String]()
    
    var delegate: CurrencyListViewControllerDelegate?
    
    var reuseIdentifier = "Currency List Table Cell"
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var currencyTableView: UITableView!
    @IBOutlet weak var tapGestureView: UIView!

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        listCountriesAndCurrencies()
        
        currencyTableView.dataSource = self
        currencyTableView.delegate = self
        currencyTableView.separatorStyle = .none

        searchBar.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeCurrencyTableView))
        tapGestureView.addGestureRecognizer(tapGesture)
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
                        let country = countryDictionary[currency]!
                        flags.append(UIImage(named: country, in: FlagKit.assetBundle, with: nil) ?? UIImage())
                        
                    }
                }
            }
            UIView.animate(withDuration: 0.1) {
                self.currencyTableView.frame.size.height = 30 * CGFloat(self.currencies.count) + self.searchBar.frame.size.height
                
                self.bottomConstraint.constant = self.view.frame.size.height  - self.currencyTableView.frame.size.height
            }

        } else {
            for currency in tempCurrencies {
                currencies.append(currency)
                let country = countryDictionary[currency]!
                flags.append(UIImage(named: country, in: FlagKit.assetBundle, with: nil) ?? UIImage())
            }
        }
        currencyTableView.reloadData()
    }
    
    func listCountriesAndCurrencies() {

        for code in currencyCodes {
            let locale = Locale(identifier: code)
            guard let currencyText = locale.localizedString(forCurrencyCode: code) else { continue }
            currencies.append(currencyText)
        }

        for i in 0..<currencyCodes.count {
            let country = countries[i]
            let currency = currencies[i]
            let countryCode = countryCodes[i]
            
            countryDictionary[currency] = countryCode
            currencyCodesDictionary[currency] = currencyCodes[i]
            
            tempCurrencies.append(currency)
            flags.append(UIImage(named: countryCode, in: FlagKit.assetBundle, with: nil) ?? UIImage())
            tempFlags.append(UIImage(named: countryCode, in: FlagKit.assetBundle, with: nil) ?? UIImage())
        }
         currencyTableView.reloadData()
      }
    
    @objc func closeCurrencyTableView() {
        delegate?.setAlpha()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK:- TableView Delegate and Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = currencyTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CurrencyListTableCell
        
        cell.itemLabel.text = currencies[indexPath.row]
        cell.itemImage.image = flags[indexPath.row]
        
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let currencyCode = currencyCodesDictionary[currencies[indexPath.row]] {
            delegate?.setRealCurrencyAndFlag(realCurrency: currencies[indexPath.row], flag: flags[indexPath.row], currencyCode: currencyCode)
            self.dismiss(animated: true, completion: nil)
        }

    }
    
}
