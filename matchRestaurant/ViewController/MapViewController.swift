//
//  MapViewController.swift
//  matchRestaurant
//
//  Created by Kazuki Omori on 2022/02/10.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
//    let location: CLLocationCoordinate2D
    
    var manager: CLLocationManager?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let first = locations.first else {
            return
        }
        let latitude = first.coordinate.latitude
        let longitude = first.coordinate.longitude
        let location = CLLocationCoordinate2DMake(latitude, longitude)
        
        mapView.setCenter(location, animated: true)
        var region = mapView.region
        region.center = location
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        
        mapView.setRegion(region, animated: true)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager = CLLocationManager()
        manager?.delegate = self
        manager?.desiredAccuracy = kCLLocationAccuracyBest
        manager?.requestWhenInUseAuthorization()
        manager?.startUpdatingLocation()
        
        mapView.delegate = self
    }
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let currentLocation = mapView.centerCoordinate
        print(currentLocation)
    }
}
