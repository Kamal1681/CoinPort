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
    var tempFlags = [UIImage]()
    var getCountryDictionary = [String: String]()
    
    var delegate: CountryListViewControllerDelegate?
    
    var reuseIdentifier = "Country List Table Cell"
    
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
                        let country = getCountryDictionary[currency]!
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
                let country = getCountryDictionary[currency]!
                flags.append(UIImage(named: country, in: FlagKit.assetBundle, with: nil) ?? UIImage())
            }
        }
        currencyTableView.reloadData()
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
                      getCountryDictionary[currencyText!] = country
                      
                      currencies.append(currencyText!)
                      tempCurrencies.append(currencyText!)
                      
                      flags.append(UIImage(named: country, in: FlagKit.assetBundle, with: nil) ?? UIImage())
                      tempFlags.append(UIImage(named: country, in: FlagKit.assetBundle, with: nil) ?? UIImage())
                      
                      currencyTableView.reloadData()
                  }
              }
          }
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
        
        let cell = currencyTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CountryListTableCell
        
        cell.itemLabel.text = currencies[indexPath.row]
        cell.itemImage.image = flags[indexPath.row]
        
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        delegate?.setRealCurrencyAndFlag(realCurrency: currencies[indexPath.row], flag: flags[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
    
}
