//
//  LocalDatabaseService.swift
//  Sixt
//
//  Created by Manuel Crovetto on 27/02/2023.
//

import Foundation
import CoreData

struct CarsLocalDatabaseImpl: CarsDao {
    
    let container = NSPersistentContainer(name: "Car")
    
    init() {
        container.loadPersistentStores { description, error in
            if let isError = error {
                print("Core data failed to load: \(isError.localizedDescription)")
                fatalError("\(isError.localizedDescription)")
            }
        }
    }
    
    func getAll() async throws -> CarsResponseEntity? {
        print("REQUESTING....")
        let request = CarsResponseEntity.fetchRequest()
        print("RESQUEST: \(request)")
         
        return try container.viewContext.fetch(request).first
    }
    
    func getById(_ id: String) async throws -> CarsResponseEntity? {
        let carsResponseEntity = try getEntityById(id)
        return carsResponseEntity
    }
    
    func delete(_ id: String) async throws {
        let carResponseEntity = try getEntityById(id)!
        let context = container.viewContext
        context.delete(carResponseEntity)
        
        do {
            try context.save()
        } catch {
            context.rollback()
            fatalError("Error: \(error.localizedDescription)")
        }
    }
    
    func deleteAllData() async throws {
        let request = CarsResponseEntity.fetchRequest()
        request.returnsObjectsAsFaults = false
        do {
            let results = try container.viewContext.fetch(request)
            results.forEach { object in
                container.viewContext.delete(object)
            }
        } catch let error {
            print("Delete all data error: \(error)")
        }
    }
    
    func insert(carModelList: [CarModel]) async throws {
        let carsResponseEntity = CarsResponseEntity(context: container.viewContext)
        carsResponseEntity.id = UUID().uuidString
        carsResponseEntity.fetchedAt = Date.now.ISO8601Format()
    
        let carModelList = try JSONEncoder().encode(carModelList)
        let carModelListJson = String(data: carModelList, encoding: .utf8)
        carsResponseEntity.cars = carModelListJson
        
        saveContext()
    }
    
    private func getEntityById(_ id: String) throws -> CarsResponseEntity? {
        let request = CarsResponseEntity.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(
            format: "id = %@", id
            )
        let context = container.viewContext
        let carListEntity = try context.fetch(request)[0]
        return carListEntity
    }
    
    private func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("\(error.localizedDescription)")
            }
        }
    }
}
