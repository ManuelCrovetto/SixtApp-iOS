//
//  GetCarList.swift
//  SixtApp
//
//  Created by Manuel Crovetto on 22/02/2023.
//

import Foundation
import CoreLocation
import CoreData
struct GetCarList {
    
    private let carService = CarService()
    private var localCarDatabase: CarsLocalDatabaseImpl = CarsLocalDatabaseImpl()
    
    func getCarList() async throws -> ResponseSource {
        let carsResponseEntity = try await localCarDatabase.getAll()
        
        if carsResponseEntity == nil {
            return try await fetchCarList()
        } else {
            if shouldRefreshCarList(fetchedAt: carsResponseEntity?.fetchedAt) {
                return try await fetchCarList()
            } else {
                return try fetchCarListFromLocalDB(carsResponseEntity: carsResponseEntity)
            }
        }
    }
    
    private func fetchCarListFromLocalDB(carsResponseEntity: CarsResponseEntity?) throws -> ResponseSource {
        if let carListJson = carsResponseEntity?.cars?.data(using: .utf8) {
            let carModelList = try JSONDecoder().decode([CarModel].self, from: carListJson)
            let carList = carModelList.map { carModel in
                Car(
                    id: carModel.id,
                    modelName: carModel.modelName ,
                    make: carModel.make ,
                    color: carModel.color ,
                    fuelLevel: carModel.fuelLevel,
                    carImageUrl: carModel.carImageUrl ,
                    carLocation: CarLocation(
                        name: carModel.name,
                        modelName: carModel.modelName,
                        coordinate: CLLocationCoordinate2D(latitude: carModel.latitude,
                                                           longitude: carModel.longitude
                                                          )
                        ),
                    name: carModel.name ,
                    fuelType: carModel.fuelType ,
                    transmission: carModel.transmission ,
                    licensePlate: carModel.licensePlate ,
                    innerCleanliness: carModel.innerCleanliness
                )
            }
            print("CAR LIST FROM DB: \(carList)")
            return ResponseSource.success(carList)
        }
        return ResponseSource.error("Empty list")
    }
    
    private func fetchCarList() async throws -> ResponseSource {
        let response = await carService.getCarList()
        print(response)
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
            try await localCarDatabase.deleteAllData()
            try await localCarDatabase.insert(carModelList: carModelList)
            
            return ResponseSource.success(carList)
        case let .error(error):
            return ResponseSource.error(error)
        }
    }
    
    private func shouldRefreshCarList(fetchedAt: String?) -> Bool  {
        guard fetchedAt != nil else {
            return false
        }
        let dateFormatter = ISO8601DateFormatter()
        let timeFetched = dateFormatter.date(from: fetchedAt!)!
        let secondsTimeDifference =  Date.now.timeIntervalSinceReferenceDate - timeFetched.timeIntervalSinceReferenceDate
        return secondsTimeDifference > 60
    }
    
}
