//
//  ViewController.swift
//  Project16
//
//  Created by Giulia Boscaro on 01/04/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit
import MapKit
import WebKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    var map: MKMapView!
    
    override func loadView() {
        view = UIView()
        
        map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(map)
        
        map.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        map.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        map.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        map.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Change map", style: .plain, target: self, action: #selector(showMapOptions))
        
        map.delegate = self
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        map.addAnnotations([london, oslo, paris, rome, washington])
        
    }
    
    @objc func showMapOptions() {
        let ac = UIAlertController(title: "Choose a map", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: changeMap))
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: changeMap))
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: changeMap))
        present(ac, animated: true)
    }
    
    func changeMap(action: UIAlertAction) {
        guard let mapType = action.title else { return }
        switch mapType {
        case "Hybrid":
            map.mapType = .hybrid
        case "Satellite":
            map.mapType = .satellite
        case "Standard":
            map.mapType = .standard
        default:
            map.mapType = .standard
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil}
        
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.pinTintColor = .black
            
            let button = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = button
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        guard let capital = view.annotation as? Capital else { return }
//
//        let placeName = capital.title
//        let placeInfo = capital.info
//
//        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
//        present(ac, animated: true)
        
        guard let annotation = view.annotation else { return }
        guard let countryName = annotation.title else { return }
        
        let wikiController = WikiViewController()
        wikiController.country = countryName
        
        navigationController?.pushViewController(wikiController, animated: true)
        
    }

}

