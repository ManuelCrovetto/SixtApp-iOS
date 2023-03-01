//
//  CarListCustomEntity.swift
//  Sixt
//
//  Created by Manuel Crovetto on 27/02/2023.
//

import Foundation
public class CarModelCustomEntity: NSObject, NSCoding, NSSecureCoding {
    public static var supportsSecureCoding: Bool = true
    

    public var id: String
    public var modelName: String
    public var make: String
    public var color: String
    public var fuelLevel: Float
    public var carImageUrl: String
    public var latitude: Double
    public var longitude: Double
    public var name: String
    public var fuelType: String
    public var transmission: String
    public var licensePlate: String
    public var innerCleanliness: String
    
    enum CodingKeys: String {
        case id = "id"
        case modelName = "modelName"
        case make = "make"
        case color = "color"
        case fuelLevel = "fuelLevel"
        case carImageUrl = "carImageUrl"
        case latitude = "latitude"
        case longitude = "longitude"
        case name = "name"
        case fuelType = "fuelType"
        case transmission = "transmission"
        case licensePlate = "licensePlace"
        case innerCleanliness = "innerCleanliness"
    }
    
    init(
        id: String,
        modelName: String,
        make: String,
        color: String,
        fuelLevel: Float,
        carImageUrl: String,
        latitude: Double,
        longitude: Double,
        name: String,
        fuelType: String,
        transmission: String,
        licensePlate: String,
        innerCleanliness: String
    ) {
        self.id = id
        self.modelName = modelName
        self.make = make
        self.color = color
        self.fuelLevel = fuelLevel
        self.carImageUrl = carImageUrl
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.fuelType = fuelType
        self.transmission = transmission
        self.licensePlate = licensePlate
        self.innerCleanliness = innerCleanliness
    }
    
    
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: CodingKeys.id.rawValue)
        coder.encode(modelName, forKey: CodingKeys.modelName.rawValue)
        coder.encode(make, forKey: CodingKeys.make.rawValue)
        coder.encode(color, forKey: CodingKeys.color.rawValue)
        coder.encode(fuelLevel, forKey: CodingKeys.fuelLevel.rawValue)
        coder.encode(carImageUrl, forKey: CodingKeys.carImageUrl.rawValue)
        coder.encode(latitude, forKey: CodingKeys.latitude.rawValue)
        coder.encode(longitude, forKey: CodingKeys.longitude.rawValue)
        coder.encode(name, forKey: CodingKeys.name.rawValue)
        coder.encode(fuelType, forKey: CodingKeys.fuelType.rawValue)
        coder.encode(transmission, forKey: CodingKeys.transmission.rawValue)
        coder.encode(licensePlate, forKey: CodingKeys.licensePlate.rawValue)
        coder.encode(innerCleanliness, forKey: CodingKeys.innerCleanliness.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let mId = aDecoder.decodeObject(forKey: CodingKeys.id.rawValue) as! String
        let mModelName = aDecoder.decodeObject(forKey: CodingKeys.modelName.rawValue) as! String
        let mMake = aDecoder.decodeObject(forKey: CodingKeys.make.rawValue) as! String
        let mColor = aDecoder.decodeObject(forKey: CodingKeys.color.rawValue) as! String
        let mFuelLevel = aDecoder.decodeFloat(forKey: CodingKeys.fuelLevel.rawValue)
        let mCarImageUrl = aDecoder.decodeObject(forKey: CodingKeys.carImageUrl.rawValue) as! String
        let mLatitude = aDecoder.decodeDouble(forKey: CodingKeys.latitude.rawValue)
        let mLongitude = aDecoder.decodeDouble(forKey: CodingKeys.longitude.rawValue)
        let mName = aDecoder.decodeObject(forKey: CodingKeys.name.rawValue) as! String
        let mFuelType = aDecoder.decodeObject(forKey: CodingKeys.fuelType.rawValue) as! String
        let mTransmission = aDecoder.decodeObject(forKey: CodingKeys.transmission.rawValue) as! String
        let mLicensePlate = aDecoder.decodeObject(forKey: CodingKeys.licensePlate.rawValue) as! String
        let mInnerCleanliness = aDecoder.decodeObject(forKey: CodingKeys.innerCleanliness.rawValue) as! String
        
        self.init(id: mId, modelName: mModelName, make: mMake, color: mColor, fuelLevel: mFuelLevel, carImageUrl: mCarImageUrl, latitude: mLatitude, longitude: mLongitude, name: mName, fuelType: mFuelType, transmission: mTransmission, licensePlate: mLicensePlate, innerCleanliness: mInnerCleanliness)
    }
    
   
}
