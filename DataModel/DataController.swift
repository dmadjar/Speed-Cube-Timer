//
//  DataController.swift
//  CubeTimerV3
//
//  Created by Daniel Madjar on 6/11/22.
//

import Foundation
import CoreData
import CloudKit

class DataController: ObservableObject {
    let container = NSPersistentCloudKitContainer(name: "Solve")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data Saved")
        } catch {
            print("Could not Save")
        }
    }
    
    func addTwoSolve(scramble: String, timeDouble: Double, timeString: String, context: NSManagedObjectContext) {
        let solve = TwoSolve(context: context)
        solve.id = UUID()
        solve.date = Date()
        solve.scramble = scramble
        solve.timeDouble = timeDouble
        solve.timeString = timeString
        
        save(context: context)
    }
    
    func addSolve(scramble: String, timeDouble: Double, timeString: String, context: NSManagedObjectContext) {
        let solve = ThreeSolve(context: context)
        solve.id = UUID()
        solve.date = Date()
        solve.scramble = scramble
        solve.timeDouble = timeDouble
        solve.timeString = timeString
        
        save(context: context)
    }
    
    func addFourSolve(scramble: String, timeDouble: Double, timeString: String, context: NSManagedObjectContext) {
        let solve = FourSolve(context: context)
        solve.id = UUID()
        solve.date = Date()
        solve.scramble = scramble
        solve.timeDouble = timeDouble
        solve.timeString = timeString
        
        save(context: context)
    }
    
}
