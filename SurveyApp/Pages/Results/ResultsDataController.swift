//
//  ResultsDataController.swift
//  Survey
//
//  Created by Irem Subası on 5.06.2023.
//

import Combine
import CoreData

final class ResultsDataController: ObservableObject {
    let container: NSPersistentContainer
    @Published var fetchedResults: [Entity] = []
    
    init() {
        container = NSPersistentContainer(name: "SurveyCoreData")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func fetchResult() -> [Entity] {
        let fetchRequest: NSFetchRequest<Entity> = Entity.fetchRequest()
        let context = container.viewContext
        
        do {
            let fetchedResults = try context.fetch(fetchRequest)
            return fetchedResults
        } catch {
            print("Error pulling data: \(error.localizedDescription)")
            return []
        }
    }

}
