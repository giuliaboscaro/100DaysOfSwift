//
//  ViewController.swift
//  Project22
//
//  Created by Giulia Boscaro on 17/04/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var label: UILabel!
    var circle: UIView!
    var locationManager: CLLocationManager?
    var alertShown: Bool = false
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .gray
        
        label = UILabel()
        label.text = "UNKNOWN"
        label.font = UIFont.systemFont(ofSize: 40, weight: .thin)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        circle = UIView()
        circle.frame = CGRect(x: 0, y: 0, width: 256, height: 256)
        circle.backgroundColor = UIColor.yellow.withAlphaComponent(0.5)
        circle.layer.cornerRadius = 128
        circle.layer.zPosition = -1
        circle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(circle)
        
        circle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        circle.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        circle.widthAnchor.constraint(equalToConstant: 256).isActive = true
        circle.heightAnchor.constraint(equalToConstant: 256).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    
    func startScanning() {
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 456, identifier: "MyBeacon")
        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(in: beaconRegion)
    }
    
    func update(distance: CLProximity) {
        UIView.animate(withDuration: 1) {
            switch distance {
            case .far:
                self.view.backgroundColor = .blue
                self.label.text = "FAR"
                self.circle.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
            case .near:
                self.view.backgroundColor = .orange
                self.label.text = "NEAR"
                self.circle.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            case .immediate:
                self.view.backgroundColor = .red
                self.label.text = "RIGHT HERE"
                self.circle.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            default:
                self.view.backgroundColor = .gray
                self.label.text = "UNKNOWN"
                self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if let beacon = beacons.first {
            if alertShown == false {
                let ac = UIAlertController(title: "Beacon detected!", message: "Wohoo", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Yay", style: .default))
                present(ac, animated: true)
                alertShown = true
            }
            update(distance: beacon.proximity)
        } else {
            update(distance: .unknown)
        }
    }
}

