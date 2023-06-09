//
//  ResultsDataController.swift
//  Survey
//
//  Created by Irem Subası on 5.06.2023.
//

import Combine
import CoreData

struct SurveyResult{
    var numberOfChooseWhiteColor: Int = 0
    var numberOfChoosePurpleColor: Int = 0
    var numberOfChooseBlueColor: Int = 0
    var numberOfChooseBlackColor: Int = 0
    var toBeCount : Int = 0
    var notToBeCount: Int = 0
    var percentLevel20: Int = 0
    var percentLevel40: Int = 0
    var percentLevel60: Int = 0
    var percentLevel80: Int = 0
    var percentLevel100: Int = 0
    var succesStep3 : Int = 0
    var succesStep8 : Int = 0
    var succesStep8Plus : Int = 0
    var typePoem: Int = 1
    var typeSong: Int = 2
    var typePicture: Int = 3
}

final class ResultsDataController: ObservableObject {
    private let container: NSPersistentContainer
    @Published var fetchedResults: [Entity] = []
    // current value subject olmalı
    private (set) var dataResults = CurrentValueSubject<SurveyResult?, Never>(nil)
    
    init() {
        container = NSPersistentContainer(name: "SurveyCoreData")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func statistics(){
        var surveyResult: SurveyResult = .init()
    let results = fetchResult()
        for data in results {
            if data.color == "White" {
                surveyResult.numberOfChooseWhiteColor += 1
            }
            if data.color == "Purple" {
                surveyResult.numberOfChoosePurpleColor += 1
            }
            if data.color == "Blue" {
                surveyResult.numberOfChooseBlueColor += 1
            }
            if data.color == "Black" {
                surveyResult.numberOfChooseBlackColor += 1
            }
            if data.percent >= 0 && data.percent < 20 {
                surveyResult.percentLevel20 += 1
            }
            if data.percent >= 20 && data.percent < 40 {
                surveyResult.percentLevel40 += 1
            }
            if data.percent >= 40 && data.percent < 60 {
                surveyResult.percentLevel60 += 1
            }
            if data.percent >= 60 && data.percent < 80 {
                surveyResult.percentLevel80 += 1
            }
            if data.percent >= 80 && data.percent < 100 {
                surveyResult.percentLevel100 += 1
            }
            if data.step >= 0 && data.step <= 3 {
                surveyResult.succesStep3 += 1
            }
            if data.step > 3 && data.step <= 8 {
                surveyResult.succesStep8 += 1
            }
            if data.step > 8  {
                surveyResult.succesStep8Plus += 1
            }
            if data.type == 1 {
                surveyResult.typePoem += 1
            }
            if data.type == 2 {
                surveyResult.typeSong += 1
            }
            if data.type == 3 {
                surveyResult.typePicture += 1
            }
            if data.toBe == true {
                surveyResult.toBeCount += 1
            }else {
                surveyResult.notToBeCount += 1
            }
        }
        self.dataResults.send(surveyResult)
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
