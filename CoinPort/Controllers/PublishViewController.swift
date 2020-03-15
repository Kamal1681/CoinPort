//
//  PublishViewController.swift
//  CoinPort
//
//  Created by Kamal Maged on 2020-02-29.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps

class PublishViewController: UIViewController, UINavigationBarDelegate, UITextViewDelegate {
    
    @IBOutlet weak var additionalNotes: UITextView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var publishButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    let db = Firestore.firestore()
    let settings = FirestoreSettings()
    
    var offer = Offer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButtons()
        configureTextView()
        configureNavigationBar()
        
        additionalNotes.delegate = self
        
        getUserDetails()
        
    }
    
    func getUserDetails() {
        if let user = Auth.auth().currentUser {
            offer.user = user.displayName!
            offer.userID = user.uid
            offer.profilePictureURL = user.photoURL
        }
        getUserCountry()
    }
    
    func getUserCountry() {
        guard let location = offer.offerLocation else { return }
        let offerCoordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let geoDecoder = GMSGeocoder()
        
        geoDecoder.reverseGeocodeCoordinate(offerCoordinate) { (results, error) in
            if error != nil {
                print(error)
            }
            if results != nil {
                self.offer.userCountry = results?.firstResult()?.country ?? ""
            }
        }
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
        navigationController?.setNavigationBarHidden(true, animated: false)
        let navigationBar = UINavigationBar()
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor(red: 71/255, green: 91/255, blue: 195/255, alpha: 1)
        navigationBar.barStyle = .black
        navigationBar.tintColor = .white
        navigationBar.delegate = self
        
        
        let item = UINavigationItem()
        item.title = "Add your notes"
        item.titleView?.tintColor = .white
        item.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(dismissProfileController))

        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Arial-BoldMT", size: 15)]
        UINavigationBar.appearance().titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        
        view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true

        navigationBar.items = [item]
        
    }
    
    @objc func dismissProfileController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureTextView() {
        additionalNotes.text = "Add any additional notes"
        additionalNotes.textColor = .lightGray
        additionalNotes.layer.borderWidth = 1.0
        additionalNotes.layer.borderColor = UIColor.blue.cgColor
        additionalNotes.layer.cornerRadius = 8
    }
   
    //MARK:- TextView handling

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Add any additional notes" {
            textView.text = nil
        }
        textView.textColor =  .black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {

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
    
    
    //MARK:- Button actions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func publishButtonPressed(_ sender: Any) {

        db.collection("Offers").addDocument(data: [
            "digitalCurrency" : offer.digitalCurrency,
            "exchangeAmount" : offer.exchangeAmount,
            "exchangeRate" : offer.exchangeRate,
            "numberOfViews" : offer.numberOfViews,
            "offerAddress" : offer.offerAddress,
            "offerLocation" : offer.offerLocation,
            "offerRequest" : offer.offerRequest?.rawValue,
            "realCurrency" : offer.realCurrency,
            "profilePictureURL" : offer.profilePictureURL?.absoluteString,
            "user" : offer.user,
            "userCountry" : offer.userCountry,
            "userID" : offer.userID,
            "postedDate" : FieldValue.serverTimestamp()
        ]) { (error) in
            if error != nil {
                print(error)
            } else {
                print("Successfully added")
            }
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        let container = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContainerController") as! ContainerController
              UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
                      self.view.addSubview(container.view)
                      self.addChild(container)
                      container.didMove(toParent: self)
              }, completion: nil)
    }
    
}
