//
//  CarService.swift
//  SixtApp
//
//  Created by Manuel Crovetto on 22/02/2023.
//

import Foundation
class CarService {
    
    func getCarList() async -> ResponseSource {
        let urlSession = URLSession.shared
        let carListUrl = URL(string: "https://cdn.sixt.io/codingtask/cars")!
        
        let (data, response) = try! await urlSession.data(from: carListUrl)
        let list = try! JSONDecoder().decode([CarModel].self, from: data)
        
        let httpRespponse = response as? HTTPURLResponse
        
        if httpRespponse?.statusCode != 200 {
            return ResponseSource.error("Connection error")
        } else {
            return ResponseSource.success(list)
        }
        
    }
}
