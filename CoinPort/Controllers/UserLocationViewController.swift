//
//  UserLocationViewController.swift
//  CoinPort
//
//  Created by Kamal Maged on 2020-02-12.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class UserLocationViewController: UIViewController, UINavigationBarDelegate, GMSMapViewDelegate, CLLocationManagerDelegate {
  
    @IBOutlet weak var mapView: UIView!
    let locationManager = CLLocationManager()
    var googleMapView: GMSMapView!
    var offer: Offer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        // Do any additional setup after loading the view.
        setLocationManager()
        setGoogleMapView()
    }
    
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

            let camera = GMSCameraPosition(target: currentLocation, zoom: 15.0)
            googleMapView.camera = camera
            let cameraUpdate = GMSCameraUpdate.setCamera(camera)
            googleMapView.animate(with: cameraUpdate)
            
            let marker = GMSMarker(position: currentLocation)
            marker.map = googleMapView

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
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
    }
    
    func setGoogleMapView() {
        googleMapView = GMSMapView(frame: mapView.frame)
        mapView.insertSubview(googleMapView, at: 0)
        googleMapView.settings.myLocationButton = true
        googleMapView.isMyLocationEnabled = true
        googleMapView.settings.compassButton = true
        
        googleMapView.delegate = self
        
        googleMapView.translatesAutoresizingMaskIntoConstraints = false
        googleMapView.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 0).isActive = true
        googleMapView.leftAnchor.constraint(equalTo: mapView.leftAnchor, constant: 0).isActive = true
        googleMapView.rightAnchor.constraint(equalTo: mapView.rightAnchor, constant: 0).isActive = true
        googleMapView.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 0).isActive = true

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

      @objc func dismissProfileController() {
        self.dismiss(animated: true, completion: nil)
    }

}
