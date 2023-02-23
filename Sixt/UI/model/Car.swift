//
//  Car.swift
//  SixtApp
//
//  Created by Manuel Crovetto on 23/02/2023.
//

import Foundation
import CoreLocation
struct Car {
    var id: String = ""
    var modelName: String = ""
    var make: String = ""
    var color: String = ""
    var fuelLevel: Float = 0.0
    var carImageUrl: String = ""
    var carLocation: CarLocation = CarLocation(name: "", coordinate: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0))
    var name: String = ""
    var fuelType: String = ""
    var transmission: String = ""
    var licensePlate: String = ""
    var innerCleanliness: String = ""
    
}
