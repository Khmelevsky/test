//
//  MapViewController.swift
//  test
//
//  Created by Alexander Khmelevsky on 20.01.17.
//  Copyright © 2017 Almet Systems. All rights reserved.
//

import UIKit
import GoogleMaps
import AFNetworking

class MapViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var mapView: GMSMapView!
    
    
    // MARK: - Vars
    fileprivate var markers = [GMSMarker]()
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure map view
        LocationManager.getUserLocation { location in
            self.findPlacesNearUser(location: location.coordinate)
            self.mapView.animate(to: GMSCameraPosition(target: location.coordinate, zoom: 13, bearing: 0, viewingAngle: 0))
        }
        mapView.isMyLocationEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Actions 
    @IBAction func myLocation(_ sender: Any) {
        LocationManager.getUserLocation { location in
            self.findPlacesNearUser(location: location.coordinate)
            self.mapView.animate(to: GMSCameraPosition(target: location.coordinate, zoom: 13, bearing: 0, viewingAngle: 0))
        }
    }
    
    // MARK: - Logic
    func findPlacesNearUser(location:CLLocationCoordinate2D) {
        API.places(latitude: location.latitude, longitude: location.longitude) { result in
            
            self.markers.forEach({ $0.map = nil })
            self.markers.removeAll()
            
            for place in result?.places ?? [] {
                if let location = place.location {
                    // configure icon view
                    let markerView = R.nib.mapMarkerView.firstView(owner: nil)
                    if let url = place.photos.first?.url() {
                        markerView?.imageView.setImageWith(URL(string: url)!)
                    } else if let url = place.iconURL {
                        markerView?.imageView.setImageWith(URL(string: url)!)
                    }
                    // configure marker
                    let marker = GMSMarker(position: location)
                    marker.iconView = markerView
                    marker.map = self.mapView
                    self.markers.append(marker)
                }
            }
        }
    }
    

}
