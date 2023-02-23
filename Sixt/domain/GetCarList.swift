//
//  GetCarList.swift
//  SixtApp
//
//  Created by Manuel Crovetto on 22/02/2023.
//

import Foundation
import CoreLocation
class GetCarList {
    
    private let carService = CarService()
    
    func getCarList() async -> ResponseSource {
        
        let response = await carService.getCarList()
        
        switch response {
        case let .success(list):
            let carModelList = list as! [CarModel]
            let carList: [Car] = carModelList.map { carModel in
                Car(
                    id: carModel.id,
                    modelName: carModel.modelName,
                    make: carModel.make,
                    color: carModel.color,
                    fuelLevel: carModel.fuelLevel,
                    carImageUrl: carModel.carImageUrl,
                    carLocation: CarLocation(
                        name: carModel.name,
                        modelName: carModel.modelName,
                        coordinate: CLLocationCoordinate2D(
                            latitude: carModel.latitude,
                            longitude: carModel.longitude
                        )
                    ),
                    name: carModel.name,
                    fuelType: carModel.fuelType,
                    transmission: carModel.transmission,
                    licensePlate: carModel.licensePlate,
                    innerCleanliness: carModel.innerCleanliness
                )
            }
            return ResponseSource.success(carList)
        case let .error(error):
            return ResponseSource.error(error)
        }
    }
}
