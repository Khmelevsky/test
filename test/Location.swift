//
//  Location.swift
//  test
//
//  Created by Alexander Khmelevsky on 20.01.17.
//  Copyright © 2017 Almet Systems. All rights reserved.
//

import Foundation
import GoogleMaps

class LocationManager {
    
    private static let defaultManager = LocationManager()
    
    private let _locationManager = LocationManagerDelegate()
    
    class func getUserLocation(callback:@escaping (_ location:CLLocation) -> Void) {
        LocationManager.defaultManager._locationManager.addChangeLocationCallback(callback: callback)
        LocationManager.defaultManager._locationManager.getCurrentUserLocation()
    }
    
    private class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {
        
        let locationManager = CLLocationManager()
        var userLocationCallback: [(_ location:CLLocation) -> Void] = []
        
        func addChangeLocationCallback(callback:@escaping (_ location:CLLocation) -> Void) {
            userLocationCallback.append(callback)
        }
        
        func getCurrentUserLocation() {
            if let vc = (UIApplication.shared.delegate as? AppDelegate)?.window?.currentViewController() {
                let status = CLLocationManager.authorizationStatus()
                locationManager.delegate = self
                if status == CLAuthorizationStatus.denied {
                    let alert = UIAlertController(title: R.string.localizable.location_denied_alert_title(), message: R.string.localizable.location_denied_alert_message(), preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: R.string.localizable.button_ok(), style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: R.string.localizable.button_settings(), style: .default, handler: { _ in
                        if #available(iOS 10, *) {
                            UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
                        } else {
                           UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
                        }
                        
                    }))
                    vc.present(alert, animated: true, completion: nil)
                } else if status == CLAuthorizationStatus.notDetermined {
                    locationManager.requestWhenInUseAuthorization()
                } else {
                    locationManager.startUpdatingLocation()
                }
            }
        }
        
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.first {
                userLocationCallback.forEach({ $0(location) })
                userLocationCallback.removeAll()
                locationManager.stopUpdatingLocation()
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .authorizedWhenInUse {
                locationManager.startUpdatingLocation()
            }
        }
    }
    
    
}
