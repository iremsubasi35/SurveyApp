//
//  ResultsViewModel.swift
//  Survey
//
//  Created by Irem Subası on 5.06.2023.
//

import Foundation

final class ResultsViewModel: ObservableObject {
    
    private let dataController: ResultsDataController
    
    @Published var surveyResults: [Entity] = []
    
    init(dataController: ResultsDataController) {
        self.dataController = dataController
    }
    
   
    func processData() {
        surveyResults = dataController.fetchResult()
        
        for result in surveyResults {
            guard let context = result.managedObjectContext else { continue }
            context.refresh(result, mergeChanges: true)
            
            let userId = result.userId 
            let name = result.name ?? ""
            let surname = result.surname ?? ""
            let birthDate = result.birthDate ?? Date()
            let type = result.type
            let color = result.color ?? ""
            let toBe = result.toBe
            let percent = result.percent
            let step = result.step
            
            // Verileri kullanma
            print("User ID: \(userId)")
            print("Name: \(name)")
            print("Surname: \(surname)")
            print("Birth Date: \(birthDate)")
            print("Type: \(type)")
            print("Color: \(color)")
            print("To Be: \(toBe)")
            print("Percent: \(percent)")
            print("Step: \(step)")
            print("----------")
        }
    }
}

