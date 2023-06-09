//
//  SurveyDataController.swift
//  Survey
//
//  Created by Irem Subası on 29.05.2023.
//

import Foundation
import Combine
import CoreData
import SwiftUI

struct AnswerOfUser: Codable {
    var userId: Int?
    var name: String
    var surname: String
    var birthDate: Date
    var type: Int
    var color: String
    var toBe: Bool
    var percent : Float
    var step : Int
    
    enum CodingKeys: CodingKey {
        case userId,name,surname,birthDate,type,color,toBe,percent,step
    }
}

enum SurveyDataControllerState{
    case idle
    case working
}

final class SurveyDataController{

    private (set) var currentState = CurrentValueSubject<SurveyDataControllerState, Never>(.idle)
    private let container: NSPersistentContainer
    
    init() {
            container = NSPersistentContainer(name: "SurveyCoreData")
            container.loadPersistentStores { _, error in
                if let error = error {
                    print("Failed to load the data \(error.localizedDescription)")
                }
            }
        }
    
    func save(context: NSManagedObjectContext) {
            currentState.send(.working)
            do {
                try context.save()
                print("Data saved")
                currentState.send(.idle)
            } catch {
                print("Data didn't save")
                currentState.send(.idle)
            }
        }
    
    func saveResult(userId: Int,
                        name: String,
                        surname: String,
                        birthDate: Date,
                        type: Int,
                        color: String,
                        toBe: Bool,
                        percent: Float,
                        step: Int) {
            let context = container.viewContext
            let answers = Entity(context: context)
            answers.id = UUID()
            answers.userId = Int16(userId)
            answers.name = name
            answers.surname = surname
            answers.birthDate = birthDate
            answers.type = Int16(type)
            answers.color = color
            answers.toBe = toBe
            answers.percent = percent
            answers.step = Int16(step)
            
            save(context: context)
        }
    

}

