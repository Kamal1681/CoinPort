//
//  OfferDetailsViewController.swift
//  CoinPort
//
//  Created by Kamal Maged on 2020-02-18.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import UIKit


class OfferDetailsViewController: UIViewController, UINavigationBarDelegate, CurrencyListViewControllerDelegate {

    @IBOutlet weak var segmentedControlView: UISegmentedControl!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var digitalCurrencyLabel: UILabel!
    
    @IBOutlet weak var offerSegmentedControlView: UISegmentedControl!
    
    @IBOutlet weak var selectCurrencyButton: UIButton!
    @IBOutlet weak var selectCurrencyButton2: UIButton!
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var rateImageView: UIImageView!
    
    @IBOutlet weak var rateCurrencyLabel: UILabel!
    @IBOutlet weak var exchangeAmount: UITextField!
    @IBOutlet weak var rateAmount: UITextField!
    @IBOutlet weak var commissionPercentage: UITextField!
    
    @IBOutlet weak var equalSignLabel: UILabel!
    @IBOutlet weak var rateTextLabel: UILabel!
    @IBOutlet weak var commissionTextLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    let currencyPickerArray = ["USD", "Euro"]
    
    var offer = Offer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureButtons()
        configureNavigationBar()
        segmentedControlSetUp()
        offerSegmentedControlSetUp()
        
        addressLabel.text = "Address:  \(offer.offerAddress)"
        digitalCurrencyLabel.text = "Currency:  \(offer.digitalCurrency)"
        
        exchangeAmount.delegate = self
        rateAmount.delegate = self
        commissionPercentage.delegate = self
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //clearPage()
    }
    
    //MARK:- Configuration Functions
    
    func configureButtons() {
        nextButton.backgroundColor = UIColor(red: 71/255, green: 91/255, blue: 195/255, alpha: 1)
        nextButton.tintColor = UIColor.white
        
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
        UINavigationBar.appearance().titleTextAttributes = attributes as [NSAttributedString.Key : Any]
          
          view.addSubview(navigationBar)
          navigationBar.translatesAutoresizingMaskIntoConstraints = false
          navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
          navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
          navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true

          navigationBar.items = [item]
          
      }
    
    func clearPage() {
          offer.exchangeRate = ""
          rateAmount.text = ""
          rateCurrencyLabel.text = ""
          rateImageView.image = nil
          
          offer.exchangeAmount = 0.0
          exchangeAmount.text = ""
          
          offer.realCurrency = ""
          selectCurrencyButton.isHidden = false
          selectCurrencyButton2.isHidden = true
            offerSegmentedControlSetUp()
        
          offer.commissionPercentage = 0.0
          commissionPercentage.text = ""
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
    
    @IBAction func nextButtonPressed(_ sender: Any) {
    
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
        else if (offer.exchangeRate == "" || rateAmount.text == "") && offerSegmentedControlView.selectedSegmentIndex == 1 {
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
            performSegue(withIdentifier: "PublishViewController", sender: self)
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
        currencyPicker.delegate = nil
        let selectedIndex = offerSegmentedControlView.selectedSegmentIndex
        switch selectedIndex {
        case 0:
            offerSegmentedControlView.selectedSegmentTintColor = .darkGray
            offer.exchangeRate = "Asking Best Offer"
            disablePageElements()
        case 1:
            offerSegmentedControlView.selectedSegmentTintColor = .darkGray
            disableCommissionElements()
        case 2:
            offerSegmentedControlView.selectedSegmentTintColor = .darkGray
            disableRateElements()
        default:
            break
        }
    }
    
    func disableRateElements() {
        currencyPicker.delegate = self
        UIView.animate(withDuration: 0.5) {
            self.commissionPercentage.isEnabled = true
            self.commissionPercentage.isHighlighted = true
            self.commissionPercentage.becomeFirstResponder()
            self.commissionTextLabel.textColor = .black
            self.commissionPercentage.textColor = .black
            self.rateAmount.isEnabled = false
            self.rateAmount.isHighlighted = false
            self.rateAmount.textColor = .lightGray
            self.rateImageView.alpha = 0.2
            self.rateCurrencyLabel.textColor = .lightGray
            self.currencyPicker.isUserInteractionEnabled = false
            self.rateTextLabel.textColor = .lightGray
            self.equalSignLabel.textColor = .lightGray
        }
    }
    
    func disableCommissionElements() {
        currencyPicker.delegate = self
        UIView.animate(withDuration: 0.5) {
            self.rateAmount.isEnabled = true
            self.rateAmount.isHighlighted = true
            self.rateAmount.becomeFirstResponder()
            self.rateAmount.textColor = .black
            self.rateImageView.alpha = 1
            self.rateCurrencyLabel.textColor = .black
            self.currencyPicker.isUserInteractionEnabled = true
            self.rateTextLabel.textColor = .black
            self.equalSignLabel.textColor = .black
            self.commissionTextLabel.textColor = .lightGray
            self.commissionPercentage.isEnabled = false
            self.commissionPercentage.isHighlighted = false
            self.commissionPercentage.textColor = .lightGray
        }
    }
    
    func disablePageElements() {
        currencyPicker.delegate = self
        UIView.animate(withDuration: 0.5) {
            self.rateAmount.isEnabled = false
            self.rateAmount.isHighlighted = false
            self.rateCurrencyLabel.textColor = .lightGray
            self.rateImageView.alpha = 0.2
            self.rateAmount.textColor = .lightGray
            self.currencyPicker.isUserInteractionEnabled = false
            self.commissionPercentage.isEnabled = false
            self.commissionPercentage.isHighlighted = false
            self.commissionPercentage.textColor = .lightGray
            self.rateTextLabel.textColor = .lightGray
            self.equalSignLabel.textColor = .lightGray
            self.commissionTextLabel.textColor = .lightGray
        }
    }
    
    //MARK:- CurrencyListViewControllerDelegate
    
    func setRealCurrencyAndFlag(realCurrency: String, flag: UIImage, currencyCode: String) {

        selectCurrencyButton.isHidden = true
        selectCurrencyButton2.isHidden = false
        selectCurrencyButton2.setImage(flag, for: .normal)
        selectCurrencyButton2.setTitle(currencyCode, for: .normal)
        rateCurrencyLabel.text = currencyCode
        rateImageView.image = flag
        offer.realCurrency = currencyCode
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
        if segue.identifier == "PublishViewController" {
            let publishViewController = segue.destination as! PublishViewController
            publishViewController.offer = offer
        }
    }
}

//MARK:- TextField Delegate

extension OfferDetailsViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = "0123456789,."
        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: string)
        if  !allowedCharacterSet.isSuperset(of: typedCharacterSet) {
            let alertController = UIAlertController(title: "Alert", message: "This Field Accepts Only Numbers", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(action)
            self.present(alertController, animated: true)
        }
        return allowedCharacterSet.isSuperset(of: typedCharacterSet)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            if let textFieldText = textField.text {
                offer.exchangeAmount = (textFieldText as NSString).doubleValue
            }
            textField.resignFirstResponder()
        case 1:
            if let textFieldText = textField.text {
                offer.exchangeRate = "\(currencyPicker.selectedRow(inComponent: 0)) = \(textFieldText) \(String(describing: rateCurrencyLabel.text))"
            }
            textField.resignFirstResponder()
        case 2:
            if let textFieldText = textField.text {
                offer.commissionPercentage = (textFieldText as NSString).doubleValue
            }
            textField.resignFirstResponder()
        default:
            break
        }

        return true
    }
}

    //MARK:- PickerView Delegate and Datasource

extension OfferDetailsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            pickerView.subviews.forEach({
            $0.layer.borderWidth = 0
            $0.isHidden = $0.frame.height < 1.0
        })
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyPickerArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = view as? UILabel
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Arial-BoldMT", size: 12)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = currencyPickerArray[row]
        if pickerView.isUserInteractionEnabled {
            pickerLabel?.textColor = .black
        } else {
            pickerLabel?.textColor = .lightGray
        }
        return pickerLabel!
    }
    
}
