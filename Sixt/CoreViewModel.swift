//
//  MainViewModel.swift
//  Sixt
//
//  Created by Manuel Crovetto on 24/02/2023.
//

import Foundation
import CoreData

class CoreViewModel: ObservableObject {
    
    let container = NSPersistentContainer(name: "Database")
    
    init() {
        container.loadPersistentStores { description, error in
            if let isError = error {
                print("Core data failed to load: \(isError.localizedDescription)")
            }
        }
    }
}
