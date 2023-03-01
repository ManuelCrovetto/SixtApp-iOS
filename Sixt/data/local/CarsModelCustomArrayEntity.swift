//
//  CarsModelCustomArrayEntity.swift
//  Sixt
//
//  Created by Manuel Crovetto on 28/02/2023.
//

import Foundation
public class CarsModelCustomArrayEntity: NSObject, NSCoding, NSSecureCoding {
    
    public var carsModelCustomEntity: [CarModelCustomEntity] = []
    
    enum Key: String {
        case carsModelCustomEntity = "carsModelCustomEntity"
    }
    
    init(carsModelCustomEntity: [CarModelCustomEntity]) {
        self.carsModelCustomEntity = carsModelCustomEntity
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(carsModelCustomEntity, forKey: Key.carsModelCustomEntity.rawValue)
    }
    
    public required convenience init?(coder: NSCoder) {
        let mCars = coder.decodeObject(forKey: Key.carsModelCustomEntity.rawValue) as! [CarModelCustomEntity]
        self.init(carsModelCustomEntity: mCars)
    }
    
    public static var supportsSecureCoding: Bool = true
    
}
