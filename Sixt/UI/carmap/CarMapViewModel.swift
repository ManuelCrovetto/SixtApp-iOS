//
//  CarMapViewModel.swift
//  SixtApp
//
//  Created by Manuel Crovetto on 23/02/2023.
//

import Foundation
@MainActor
class CarMapViewModel: ObservableObject {
    
    private let getCarList = GetCarList()
    @Published var carList: [Car] = []
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    @Published var carLocations: [CarLocation] = []
    @Published var carLocationSelected = CarLocation()
    
    func getCarList() async throws {
        let responseSource = try await self.getCarList.getCarList()
        
        DispatchQueue.main.async {
            switch responseSource {
            case let .error(errorMessage):
                self.isError = true
                self.errorMessage = errorMessage
            
            case let .success(list):
                self.isError = false
                self.errorMessage = ""
                let carList = list as! [Car]
                self.carList = carList
                self.carLocations = carList.map({ car in
                    car.carLocation
                })
                
            }
        }
    }
    
}
