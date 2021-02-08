//
//  NearmeViewController.swift
//  CheapBook
//
//  Created by Yavuz BİTMEZ on 27.01.2021.
//  Copyright © 2021 Yavuz BİTMEZ. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class NearmeViewController: UIViewController, MKMapViewDelegate {

    let mapView = MKMapView()
    var locationManager:CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Helper.backgroundColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .red
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        mapView.frame = .init(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        mapView.mapType = .standard
        mapView.delegate = self
        mapView.isZoomEnabled = true
        
        view.addSubview(mapView)
        

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            determineMyCurrentLocation()
          }
 
    
}
extension NearmeViewController:CLLocationManagerDelegate {
    func determineMyCurrentLocation() {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            
            if CLLocationManager.locationServicesEnabled() {
                locationManager.startUpdatingLocation()
                //locationManager.startUpdatingHeading()
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let userLocation:CLLocation = locations[0] as CLLocation
            print("Updating location")
            manager.stopUpdatingLocation()
            let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                    
            mapView.setRegion(region, animated: true)
                    
                // Drop a pin at user's Current Location
            let myAnnotation: MKPointAnnotation = MKPointAnnotation()
            myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
            myAnnotation.title = "Current location"
            mapView.addAnnotation(myAnnotation)
            
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.coordinate = CLLocationCoordinate2DMake( 42.3180, 35.3796);
            pointAnnotation.title = "Kartal"
            mapView.addAnnotation(pointAnnotation)
            
            
            let pointAnnotation2 = MKPointAnnotation()
            pointAnnotation2.coordinate = CLLocationCoordinate2DMake( 40.916061, 29.211163);
            pointAnnotation2.title = "Kitap"
            mapView.addAnnotation(pointAnnotation2)
            
            let pointAnnotation3 = MKPointAnnotation()
            pointAnnotation3.coordinate = CLLocationCoordinate2DMake( 42.3180, 35.3796);
            pointAnnotation3.title = "kitap3"
            mapView.addAnnotation(pointAnnotation3)
        }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?
        {
            if !(annotation is MKPointAnnotation) {
                return nil
            }
            
            let annotationIdentifier = "AnnotationIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
            
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                annotationView!.canShowCallout = true
            }
            else {
                annotationView!.annotation = annotation
            }
            
            let pinImage = UIImage(named: "tab1")
            annotationView!.image = pinImage
            return annotationView
        }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("bastım")
    }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
        {
            print("Error \(error)")
        }
}
