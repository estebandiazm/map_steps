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
    
    @IBOutlet weak var standarItem: UITabBarItem!
    
    private var oldLocation : CLLocation!;
    
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
        

        if (nil == oldLocation){
            oldLocation = locations[0]
        }
        
        let distance : CLLocationDistance = manager.location!.distance(from: oldLocation)
        print("Nueva ubicaicon \(oldLocation) Distancia: \(distance)")
        if (distance > 50){
        
            let pin = MKPointAnnotation()
            pin.title = "Punto"
            pin.subtitle = "Pase por aquí"
            pin.coordinate = point
            
            map.addAnnotation(pin)
            
            map.centerCoordinate = point
            
            let latDelta:CLLocationDegrees = 0.05
            let lonDelta:CLLocationDegrees = 0.05
            
            let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
            
            let region = MKCoordinateRegion(center: point, span: span)
            map.setRegion(region, animated: true)
            
            map.showsScale = true
            
            oldLocation = locations[0]
        }
        
    }
    

    @IBAction func satelliteAction(_ sender: Any) {
        map.mapType = MKMapType.satellite
    }

    @IBAction func mapStandardAction(_ sender: Any) {
         map.mapType = MKMapType.standard
    }
    @IBAction func mapHybridAction(_ sender: Any) {
         map.mapType = MKMapType.hybrid
    }
}

