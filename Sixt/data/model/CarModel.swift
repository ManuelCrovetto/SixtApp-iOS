//
//  File.swift
//  SixtApp
//
//  Created by Manuel Crovetto on 22/02/2023.
//

import Foundation
struct CarModel: Decodable {
    let id: String
    let modelName: String
    let make: String
    let color: String
    let fuelLevel: Float
    let carImageUrl: String
    let latitude: Double
    let longitude: Double
    let name: String
    let fuelType: String
    let transmission: String
    let licensePlate: String
    let innerCleanliness: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case modelName
        case make
        case color
        case fuelLevel
        case carImageUrl
        case latitude
        case longitude
        case name
        case fuelType
        case transmission
        case licensePlate
        case innerCleanliness
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.modelName = try container.decode(String.self, forKey: .modelName)
        self.make = try container.decode(String.self, forKey: .make)
        self.color = try container.decode(String.self, forKey: .color)
        self.fuelLevel = try container.decode(Float.self, forKey: .fuelLevel)
        self.carImageUrl = try container.decode(String.self, forKey: .carImageUrl)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        self.name = try container.decode(String.self, forKey: .name)
        self.fuelType = try container.decode(String.self, forKey: .fuelType)
        self.transmission = try container.decode(String.self, forKey: .transmission)
        self.licensePlate = try container.decode(String.self, forKey: .licensePlate)
        self.innerCleanliness = try container.decode(String.self, forKey: .innerCleanliness)
    }
}
