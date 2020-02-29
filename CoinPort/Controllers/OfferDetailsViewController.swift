//
//  OfferDetailsViewController.swift
//  CoinPort
//
//  Created by Kamal Maged on 2020-02-18.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import UIKit


class OfferDetailsViewController: UIViewController, UINavigationBarDelegate, UITextFieldDelegate, UITextViewDelegate, CurrencyListViewControllerDelegate {

    @IBOutlet weak var segmentedControlView: UISegmentedControl!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var digitalCurrencyLabel: UILabel!
    
    @IBOutlet weak var offerSegmentedControlView: UISegmentedControl!
    
    @IBOutlet weak var selectCurrencyButton: UIButton!
    @IBOutlet weak var selectCurrencyButton2: UIButton!
    
    @IBOutlet weak var exchangeAmount: UITextField!
    @IBOutlet weak var rateAmount: UITextField!
    @IBOutlet weak var commissionPercentage: UITextField!
    
    @IBOutlet weak var publishButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var additionalNotes: UITextView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    var keyboardHeight : CGFloat?
    
    var offer = Offer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureButtons()
        configureNavigationBar()
        configureTextView()
        segmentedControlSetUp()
        offerSegmentedControlSetUp()
        
        addressLabel.text = "Address:  \(offer.offerAddress)"
        digitalCurrencyLabel.text = "Currency:  \(offer.digitalCurrency)"
        
        exchangeAmount.delegate = self
        rateAmount.delegate = self
        commissionPercentage.delegate = self
        additionalNotes.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidChange(notication:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(true)
        offer.exchangeRate = ""
        offer.exchangeAmount = 0.0
        offer.realCurrency = ""
        offer.commissionPercentage = 0.0
    }
    
    func publish() {
        
    }
    
    //MARK:- Configuration Functions
    
    func configureButtons() {
        publishButton.backgroundColor = UIColor(red: 71/255, green: 91/255, blue: 195/255, alpha: 1)
        publishButton.tintColor = UIColor.white
        
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
    
    func configureTextView() {
        additionalNotes.text = "Add any additional notes"
        additionalNotes.textColor = .lightGray
        additionalNotes.layer.borderWidth = 1.0
        additionalNotes.layer.borderColor = UIColor.blue.cgColor
        additionalNotes.layer.cornerRadius = 8
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
    
    
    @IBAction func publishButtonPressed(_ sender: Any) {
    
        if segmentedControlView.selectedSegmentIndex == -1 {
            let alertController = UIAlertController(title: "Alert", message: "Select request type Buy/Sell ?", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true)

        }
        else if offer.exchangeAmount == 0 {
            let alertController = UIAlertController(title: "Alert", message: "Please enter offered amount", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true)
        }
        else if offer.realCurrency == "" || selectCurrencyButton2.imageView?.image == nil {
            let alertController = UIAlertController(title: "Alert", message: "Currency unit is missing", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true)

        }
        else if offerSegmentedControlView.selectedSegmentIndex == -1 {
            let alertController = UIAlertController(title: "Alert", message: "Select Exchange Rate", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true)

        }
        else if offer.exchangeRate == "" && offerSegmentedControlView.selectedSegmentIndex == 1 {
            let alertController = UIAlertController(title: "Alert", message: "Please enter your price", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true)
        }
        else if offer.commissionPercentage == 0.0 && offerSegmentedControlView.selectedSegmentIndex == 2 {
            let alertController = UIAlertController(title: "Alert", message: "Please enter your percentage", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true)
        }
        else {
            publish()
        }
    }
    
    @objc func dismissProfileController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentedControlTapped(_ sender: Any) {
        segmentedControlSetUp()
    }
    
    @IBAction func offerSegmentedControlTapped(_ sender: Any) {
        offerSegmentedControlSetUp()
    }
    
    //MARK:- Segmented Control Setup
    
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
    
    func offerSegmentedControlSetUp() {
        
        let selectedIndex = offerSegmentedControlView.selectedSegmentIndex
        switch selectedIndex {
        case 0:
            offerSegmentedControlView.selectedSegmentTintColor = .darkGray
            offer.exchangeRate = "Asking Best Offer"
            rateAmount.isEnabled = false
            commissionPercentage.isEnabled = false
        case 1:
            offerSegmentedControlView.selectedSegmentTintColor = .darkGray
            rateAmount.isEnabled = true
            commissionPercentage.isEnabled = false
        case 2:
            offerSegmentedControlView.selectedSegmentTintColor = .darkGray
            commissionPercentage.isEnabled = true
            rateAmount.isEnabled = false
        default:
            break
        }
    }

    //MARK:- TextField Delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = "0123456789,."
        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: string)
        if !allowedCharacterSet.isSuperset(of: typedCharacterSet) {
            let alertController = UIAlertController(title: "Alert", message: "This Field Accepts Only Numbers", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(action)
            self.present(alertController, animated: true)
        }
        return allowedCharacterSet.isSuperset(of: typedCharacterSet)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.clearsOnBeginEditing = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            offer.exchangeAmount = (textField.text! as NSString).doubleValue
            textField.resignFirstResponder()
        case 1:
            if let textFieldText = textField.text {
                offer.exchangeRate = textFieldText
                textField.resignFirstResponder()
            }
        case 2:
            textField.resignFirstResponder()
        default:
            break
        }

        return true
    }
    
    //MARK:- TextView handling

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Add any additional notes" {
            textView.text = nil
        }
        textView.textColor =  .black

        UIView.animate(withDuration: 0.5) {
            guard let keyboardHeight = self.keyboardHeight else { return }
            self.bottomConstraint.constant = keyboardHeight - 50
            self.view.layoutIfNeeded()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {

        UIView.animate(withDuration: 0.5) {
            self.bottomConstraint.constant = 75
            self.view.layoutIfNeeded()
        }
        if textView.text == "" {
            textView.textColor = .lightGray
            textView.text = "Add any additional notes"
        }
        offer.notes = textView.text
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    @objc func keyboardDidChange(notication: NSNotification) {
        let value = notication.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
         self.keyboardHeight = value?.size.height
    }
    
    //MARK:- CurrencyListViewControllerDelegate
    
    func setRealCurrencyAndFlag(realCurrency: String, flag: UIImage) {

        selectCurrencyButton.isHidden = true
        selectCurrencyButton2.isHidden = false
        selectCurrencyButton2.setImage(flag, for: .normal)
        selectCurrencyButton2.setTitle(realCurrency, for: .normal)
        offer.realCurrency = realCurrency
        setAlpha()
    }
    
    func setAlpha() {
        self.view.alpha = 1
    }

    //MARK:- Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CurrencyListPopOver" {
            
            let currencyListPopOver = segue.destination as! CurrencyListViewController
            currencyListPopOver.delegate = self
            self.view.alpha = 0.7
        }
    }

    
}
