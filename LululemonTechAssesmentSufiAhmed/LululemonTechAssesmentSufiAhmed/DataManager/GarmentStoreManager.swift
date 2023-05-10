//
//  GarmentStorePresistentManager.swift
//  LululemonTechAssesmentSufiAhmed
//
//  Created by Sufiyan Ahmed on 5/10/23.
//

import Foundation
import CoreData

// Manager class to handle all coreData methods
class GarmentStoreManger {
    
    var persistentStoreContainer: NSPersistentContainer

    init() {
        persistentStoreContainer = NSPersistentContainer(name: "GarmentStore")
        persistentStoreContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error Loading: \(error.localizedDescription)")
            }
        }
    }
    
    //saving to presistent store
    func saveContext () {
        let context = persistentStoreContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // print error
                print("Failed to save garment: \(error.localizedDescription)")
            }
        }
    }
    
    //update a current item in store
    func updateGarment() {
        do {
            try persistentStoreContainer.viewContext.save()
        } catch {
            persistentStoreContainer.viewContext.rollback()
        }
    }
    
    //delete particular item in store
    func deleteGarment(clothes: Garment) {
        
        persistentStoreContainer.viewContext.delete(clothes)
        
        do {
            try persistentStoreContainer.viewContext.save()
        } catch {
            persistentStoreContainer.viewContext.rollback()
            print("Failed: \(error)")
        }
        
    }
    
    //adding new item to store
    func addNewGarment(_ name: String){
        let garmentData = Garment(context: persistentStoreContainer.viewContext)
        garmentData.garmentName = name
        garmentData.creationDate = Date()
        saveContext()
    }
    
    //fetch method to get items from store
    func fetchGarments() -> [Garment] {
        let fetchRequest: NSFetchRequest<Garment> = Garment.fetchRequest()
        
        do {
            return try persistentStoreContainer.viewContext.fetch(fetchRequest)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    

    
    
}
