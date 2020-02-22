//
//  UserLocationViewController.swift
//  CoinPort
//
//  Created by Kamal Maged on 2020-02-12.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import GoogleMaps
import GooglePlaces
import CoreLocation

class UserLocationViewController: UIViewController, UINavigationBarDelegate, GMSMapViewDelegate, CLLocationManagerDelegate {
  
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var googleMapView: GMSMapView!

    var offer = Offer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureButtons()
        
        setLocationManager()
        setGoogleMapView()
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
          item.title = "Locate the appropriate interview for you on the map"
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

    //MARK:- Button actions
    
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
    
    // MARK:- Location management functions
    
    func setLocationManager() {
        
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locationManager.location?.coordinate {
            setMapAndMarker(location: currentLocation)
            
            getFullAddressFromLocation(location: currentLocation) { (fullAddressResult) in
                DispatchQueue.main.async {
                    self.addressLabel.text = fullAddressResult
                    self.offer.offerLocation = GeoPoint(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
                    self.offer.offerAddress = fullAddressResult
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.denied {
            let alertController = UIAlertController(title: "Location Acces Disabled", message: "You need to enable location access in settings in order to use this app", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (action) in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            alertController.addAction(settingsAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func getFullAddressFromLocation (location: CLLocationCoordinate2D, complete: @escaping (String) -> Void) {
        
        var formattedAddress: String? = ""
        let url = URL(string: "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(String(describing: location.latitude)),\(String(describing: location.longitude))&language=en&key=\(googleApiKey)")
        
        URLSession.shared.dataTask(with: url! as URL) { (data, response, error) -> Void in
            do {
                if data != nil{
                    let dict = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as!  NSDictionary
                    let results = dict["results"] as! NSArray
                    let formattedAddressArray = results.value(forKey: "formatted_address") as! NSArray
                    formattedAddress = formattedAddressArray.firstObject as? String
                    
                    complete(formattedAddress ?? "")
                }
            }catch {
                print("Error request")
            }
        }.resume()
    }
    
    // MARK:- MapView Functions
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        setMapAndMarker(location: coordinate)
        
        getFullAddressFromLocation(location: coordinate) { (fullAddressResult) in
            DispatchQueue.main.async {
                self.addressLabel.text = fullAddressResult
                self.offer.offerLocation = GeoPoint(latitude: coordinate.latitude, longitude: coordinate.longitude)
                self.offer.offerAddress = fullAddressResult
            }
        }
    }
    
    func setGoogleMapView() {
        googleMapView = GMSMapView(frame: mapView.frame)
        mapView.insertSubview(googleMapView, at: 0)
        //googleMapView.settings.myLocationButton = true
        googleMapView.isMyLocationEnabled = true
        googleMapView.settings.compassButton = true

        
        googleMapView.delegate = self
        
        googleMapView.translatesAutoresizingMaskIntoConstraints = false
        googleMapView.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 0).isActive = true
        googleMapView.leftAnchor.constraint(equalTo: mapView.leftAnchor, constant: 0).isActive = true
        googleMapView.rightAnchor.constraint(equalTo: mapView.rightAnchor, constant: 0).isActive = true
        googleMapView.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 0).isActive = true
        setMapAndMarker(location: locationManager.location!.coordinate)

    }
    
    func setMapAndMarker(location: CLLocationCoordinate2D) {
        googleMapView.clear()
        let camera = GMSCameraPosition(target: location, zoom: 15.0)
        googleMapView.camera = camera
        let cameraUpdate = GMSCameraUpdate.setCamera(camera)
        googleMapView.animate(with: cameraUpdate)
        
        let marker = GMSMarker(position: location)
        marker.map = googleMapView
    }
    
    // MARK: - Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OpenOfferDetailsViewController" {
            let offerDetailsViewController = segue.destination as! OfferDetailsViewController
            offerDetailsViewController.offer = offer
        }
        
    }

}
