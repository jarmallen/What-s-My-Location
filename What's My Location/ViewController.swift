//
//  ViewController.swift
//  What's My Location
//
//  Created by Jared Allen on 2/1/16.
//  Copyright © 2016 Jared Allen. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var nearestAddressLabel: UILabel!
    
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        // print(userLocation)
        
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        let course = userLocation.course
        let speed = userLocation.speed
        let altitude = userLocation.altitude
        
        latitudeLabel.text = String(latitude)
        longitudeLabel.text = String(longitude)
        courseLabel.text = String(course)
        speedLabel.text = String(speed)
        altitudeLabel.text = String(altitude)
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) -> Void in
            if error != nil {
                print(error)
                
            } else {
                if let pm = placemarks?[0] {
                    
                    var locality: String = ""
                    
                    if pm.locality != nil {
                        locality = pm.locality!

                    }
                    
                    let nearestLocality = "\(locality)"
                    
                    self.nearestAddressLabel.text = nearestLocality
                    
                    }
                   
                }
            }
        
    }


}

