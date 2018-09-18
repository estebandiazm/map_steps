//
//  ViewController.swift
//  Map
//
//  Created by Juan Diaz on 18/09/18.
//  Copyright © 2018 Juan Diaz. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    private let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()

    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
            map.showsUserLocation = true
        } else {
            manager.stopUpdatingLocation()
            map.showsUserLocation = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var point = CLLocationCoordinate2D()
        point.latitude = manager.location!.coordinate.latitude
        point.longitude = manager.location!.coordinate.longitude
        
        let pin = MKPointAnnotation()
        pin.title = "Punto"
        pin.subtitle = "Pase por aquí"
        pin.coordinate = point
        
        map.addAnnotation(pin)
    }
}

