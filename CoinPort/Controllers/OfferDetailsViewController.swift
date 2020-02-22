//
//  OfferDetailsViewController.swift
//  CoinPort
//
//  Created by Kamal Maged on 2020-02-18.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import UIKit

class OfferDetailsViewController: UIViewController, UINavigationBarDelegate, UITextFieldDelegate, CountryListViewControllerDelegate {

    @IBOutlet weak var segmentedControlView: UISegmentedControl!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var digitalCurrencyLabel: UILabel!
    
    @IBOutlet weak var selectCurrencyButton: UIButton!
    @IBOutlet weak var selectCurrencyButton2: UIButton!
    
    @IBOutlet weak var exchangeAmount: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    
    var offer = Offer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureButtons()
        configureNavigationBar()
        segmentedControlSetUp()
        addressLabel.text = "Address:  \(offer.offerAddress)"
        digitalCurrencyLabel.text = "Currency:  \(offer.digitalCurrency)"
        
        exchangeAmount.delegate = self
    }
    
    
    //MARK:- Configuration Functions
    
    func configureButtons() {
        nextButton.backgroundColor = UIColor(red: 71/255, green: 91/255, blue: 195/255, alpha: 1)
        nextButton.tintColor = UIColor.white
        nextButton.isUserInteractionEnabled = false
        
        backButton.backgroundColor = UIColor(red: 71/255, green: 91/255, blue: 195/255, alpha: 1)
        backButton.tintColor = UIColor.white
        
        closeButton.backgroundColor = UIColor(red: 71/255, green: 91/255, blue: 195/255, alpha: 1)
        closeButton.tintColor = UIColor.white
    }
    
    func configureNavigationBar() {
          let navigationBar = UINavigationBar()
          navigationBar.isTranslucent = false
          navigationBar.barTintColor = UIColor(red: 71/255, green: 91/255, blue: 195/255, alpha: 1)
          navigationBar.barStyle = .black
          navigationBar.tintColor = .white
          navigationBar.delegate = self
          
          
          let item = UINavigationItem()
          item.title = "Edit your offer details"
          item.titleView?.tintColor = .white
          item.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(dismissProfileController))
          
          let attributes = [NSAttributedString.Key.font: UIFont(name: "Arial-BoldMT", size: 12)]
          UINavigationBar.appearance().titleTextAttributes = attributes
          
          view.addSubview(navigationBar)
          navigationBar.translatesAutoresizingMaskIntoConstraints = false
          navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
          navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
          navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true

          navigationBar.items = [item]
          
      }

    //MARK:- Button Actions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        let container = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContainerController") as! ContainerController
              UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
                      self.view.addSubview(container.view)
                      self.addChild(container)
                      container.didMove(toParent: self)
              }, completion: nil)
    }
    
    @objc func dismissProfileController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentedControlTapped(_ sender: Any) {
        segmentedControlSetUp()
    }
    
    func segmentedControlSetUp() {
        
        let selectedIndex = segmentedControlView.selectedSegmentIndex
        switch selectedIndex {
            
        case 0:
            segmentedControlView.selectedSegmentTintColor = .green
            offer.offerRequest = OfferRequest.ToBuy
        case 1:
            segmentedControlView.selectedSegmentTintColor = .red
            offer.offerRequest = OfferRequest.ForSale
        default:
            break
        }
    }
    
    //MARK:- TextField Delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        offer.exchangeAmount = (textField.text! as NSString).doubleValue
        textField.resignFirstResponder()
        return true
    }
    
    //MARK:- CountryListViewControllerDelegate
    
    func setRealCurrencyAndFlag(realCurrency: String, flag: UIImage) {
        selectCurrencyButton.isHidden = true
        selectCurrencyButton2.isHidden = false
        selectCurrencyButton2.setImage(flag, for: .normal)
        selectCurrencyButton2.setTitle(realCurrency, for: .normal)
        offer.realCurrency = realCurrency
        self.view.alpha = 1
    }

    //MARK:- Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CountryListPopOver" {
            
            let countryListPopOver = segue.destination as! CountryListViewController
            countryListPopOver.delegate = self
            self.view.alpha = 0.7
        }
    }

    
}
