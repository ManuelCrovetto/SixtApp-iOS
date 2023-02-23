//
//  Location.swift
//  SixtApp
//
//  Created by Manuel Crovetto on 23/02/2023.
//

import Foundation
import CoreLocation


struct CarLocation: Identifiable {
    let id = UUID()
    var name: String = ""
    var modelName: String = ""
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
}



