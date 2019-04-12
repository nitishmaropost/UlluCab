//
//  UlluProtocols.swift
//  UlluCab
//
//  Created by maropost on 11/04/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import Foundation
import CoreLocation

@objc protocol UlluLocationClientDelegate: NSObjectProtocol {
    @objc func locationClientDidUpdateLocations(locations: [CLLocation])
    @objc func locationClientDidFailWithError(error: Error)
    @objc func locationClientDidChangeAuthorizationStatus(status: CLAuthorizationStatus)
}
