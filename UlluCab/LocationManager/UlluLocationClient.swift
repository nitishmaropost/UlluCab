//
//  UlluLocationManager.swift
//  UlluCab
//
//  Created by maropost on 11/04/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit
import CoreLocation

class UlluLocationClient: CLLocationManager {

    static let shared = UlluLocationClient()
    var ulluLocationDelegate: UlluLocationClientDelegate!
    var locationClientStatus: UlluLocationClientStatus!
    var locationManager: CLLocationManager!
    
    // Private initializer
    private override init() {        
    }
    
    /// Initialization of location manager and it's delegate along with accuracy.
    ///
    /// - Parameter locationAccuracy: Location accuracy.
    func clientWithAccuracy(locationAccuracy: CLLocationAccuracy) -> UlluLocationClient {
        let client = UlluLocationClient()
        client.locationManager = CLLocationManager()
        client.locationManager.delegate = client
        client.locationManager.desiredAccuracy = locationAccuracy
        
        return client
    }
    
    /// Start updating location
    func startReportingLocation() {
        if self.locationManager == nil {
            self.locationManager = CLLocationManager()
            self.locationManager.delegate = self
        }
        
        // Respond to selectors
        if (Bundle.main.object(forInfoDictionaryKey: "NSLocationWhenInUseUsageDescription") != nil) {
            if self.locationManager.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization)) {
                self.locationManager.requestWhenInUseAuthorization()
            }
        } else if (Bundle.main.object(forInfoDictionaryKey: "NSLocationAlwaysUsageDescription") != nil) {
            if self.locationManager.responds(to: #selector(CLLocationManager.requestAlwaysAuthorization)) {
                self.locationManager.requestAlwaysAuthorization()
            }
        }
        
        // Start updates
        self.locationClientStatus = UlluLocationClientStatus.UlluLocationClientUpdating
        self.locationManager.startUpdatingLocation()
    }
    
    /// Stop updating location
    func stopReportingLocation() {
        self.locationClientStatus = UlluLocationClientStatus.UlluLocationClientNotUpdating
        self.locationManager.stopUpdatingLocation()
    }
    
    /// Set location accuracy
    ///
    /// - Parameter accuracy: Location accuracy.
    func setAccuracy(accuracy: CLLocationAccuracy) {
        self.locationManager.desiredAccuracy = accuracy
    }
}

// MARK: - Location manager delegate
extension UlluLocationClient: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.stopReportingLocation()
        if self.ulluLocationDelegate != nil && self.ulluLocationDelegate.responds(to: #selector(UlluLocationClientDelegate.locationClientDidUpdateLocations(locations:))) {
            self.ulluLocationDelegate.locationClientDidUpdateLocations(locations: locations)
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.stopReportingLocation()
        if self.ulluLocationDelegate != nil && self.ulluLocationDelegate.responds(to: #selector(UlluLocationClientDelegate.locationClientDidFailWithError(error:))) {
            self.ulluLocationDelegate.locationClientDidFailWithError(error: error)
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied, .restricted:
            self.stopReportingLocation()
        default:
            break
        }
        
        if self.ulluLocationDelegate != nil && self.ulluLocationDelegate.responds(to: #selector(UlluLocationClientDelegate.locationClientDidChangeAuthorizationStatus(status:))) {
            self.ulluLocationDelegate.locationClientDidChangeAuthorizationStatus(status: status)
        }
    }
}
