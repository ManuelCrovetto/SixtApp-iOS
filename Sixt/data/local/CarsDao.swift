//
//  CarsSource.swift
//  Sixt
//
//  Created by Manuel Crovetto on 27/02/2023.
//

import Foundation

protocol CarsDao {
    func getAll() async throws -> CarsResponseEntity?
    func getById(_ id: String) async throws -> CarsResponseEntity?
    func delete(_ id: String) async throws -> ()
    func deleteAllData() async throws -> ()
    func insert(carModelList: [CarModel]) async throws -> ()
    
}
