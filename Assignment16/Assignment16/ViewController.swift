//
//  ViewController.swift
//  Assignment16
//
//  Created by Suhaas Choppavarapu on 9/10/20.
//  Copyright © 2020 Suhaas Choppavarapu. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    //MARK:- IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK:- Properties
    var locationServiceManager : CLLocationManager!
    var i = 0
    
    var latitudes: [Double] = [40.7128, 37.773972, 34.052235, 36.114647, 38.9072,
                               25.761681,41.881832, 32.715736, 47.608013, 42.361145]
    var longitudes: [Double] = [-74.0060, -122.431297, -118.243683, -115.172813, -77.0369,
                                -80.191788, -87.623177, -117.161087, -122.335167, -71.057083]
    var titles: [String] = ["New York City", "San Francisco","Los Angeles", "Las Vegas", "Washington DC",
                            "Miami", "Chicago","San Diego", "Seattle", "Boston"]
    var subTitles: [String] = ["New York", "California","California", "Nevada", "Virginia",
                               "Florida", "Illinois","California", "Washington", "Massachusets"]
    
    //MARK:- View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        locationServiceManager = CLLocationManager()
        locationServiceManager.delegate = self
        
        locationServiceManager.requestAlwaysAuthorization()
        locationServiceManager.requestWhenInUseAuthorization()
    }
    
    //MARK:- CLLocationManagerDelegate Methods
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            mapView.showsUserLocation = true
            setupLocationManager()
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            setupLocationManager()
        case .denied:
            print("user selected denied")
        default:
            print("user selected other")
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let center = CLLocationCoordinate2D(latitude: latitudes[i] , longitude: longitudes[i] )
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
        mapView.setRegion(region, animated: true)
        
        let anno = MKPointAnnotation()
        anno.coordinate = center
        anno.title = titles[i]
        anno.subtitle = subTitles[i]
        mapView.addAnnotation(anno)
    }
    //MARK:- IBActions
    @IBAction func previousButtonTapped(_ sender: Any) {
        prevItem()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        nextItem()
    }
    //MARK:- Helper Methods
    func setupLocationManager() {
        locationServiceManager.desiredAccuracy = kCLLocationAccuracyBest
        locationServiceManager.startUpdatingLocation()
    }
    
    func nextItem() {
        i += 1
        i = i % latitudes.count;
        print(i)
        return
    }
    
    func prevItem() {
        if (i == 0) {
            i = latitudes.count;
        }
        i -= 1
        print(i)
        return
    }
}

