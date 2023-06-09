//
//  ResultsViewModel.swift
//  Survey
//
//  Created by Irem Subası on 5.06.2023.
//

import Foundation
import Combine

struct SurveyDataResultsPresentation: Identifiable{
    var id: UUID = .init()
    var numberOfChooseWhiteColor: String = ""
    var numberOfChoosePurpleColor: String = ""
    var numberOfChooseBlueColor: String = ""
    var numberOfChooseBlackColor: String = ""
    var optimisticLevel20: String = ""
    var optimisticLevel40: String = ""
    var optimisticLevel60: String = ""
    var optimisticLevel80: String = ""
    var optimisticLevel100: String = ""
    var selectToBe: String = ""
    var selectNotToBe: String = ""
    var stepValue3: String = ""
    var stepValue8: String = ""
    var stepValue8Plus: String = ""
    var poemType: String = ""
    var songType: String = ""
    var picturType: String = ""
}
final class ResultsViewModel: ObservableObject {
    
    private let dataController: ResultsDataController
    
    @Published var surveyDataResultsPresentation: SurveyDataResultsPresentation = .init()
    //@Published var surveyResults: [Entity] = []
    private var cancellables = Set<AnyCancellable>()
    
    init(dataController: ResultsDataController) {
        self.dataController = dataController
        addListeners()
    }
    
   
//    func processData() {
//        surveyResults = dataController.fetchResult()
//        var typeCounts: [Int: Int] = [:]
//        var colorCounts: [String: Int] = [:]
//        var toBeCount = 0
//        var notToBeCount = 0
//        var groupPercentCounts: [String: Int] = [:]
//        var group = ""
//        var stepCounts: [Int: Int] = [:]
//
//        for result in surveyResults {
//            guard let context = result.managedObjectContext else { continue }
//            context.refresh(result, mergeChanges: true)
//
//            let userId = result.userId
//            let name = result.name ?? ""
//            let surname = result.surname ?? ""
//            let birthDate = result.birthDate ?? Date()
//            let type = result.type
//            let color = result.color ?? ""
//            let toBe = result.toBe
//            let percent = result.percent
//            let step = result.step
//
//            //Type
//            if let count = typeCounts[Int(type)] {
//                typeCounts[Int(type)] = count + 1
//            } else {
//                typeCounts[Int(type)] = 1
//            }
//
//            //Color
//            if let count = colorCounts[color] {
//                colorCounts[color] = count + 1
//            } else {
//                colorCounts[color] = 1
//            }
//
//            //ToBe
//            if toBe {
//                toBeCount += 1
//            } else {
//                notToBeCount += 1
//            }
//
//            // Percent
//            if percent >= 0 && percent < 20 {
//                group = "0-20%"
//            } else if percent >= 20 && percent < 40 {
//                group = "20-40%"
//            } else if percent >= 40 && percent < 60 {
//                group = "40-60%"
//            } else if percent >= 60 && percent < 80 {
//                group = "60-80%"
//            } else if percent >= 80 && percent <= 100 {
//                group = "80-100%"
//            }
//
//            if let count = groupPercentCounts[group] {
//                groupPercentCounts[group] = count + 1
//            } else {
//                groupPercentCounts[group] = 1
//            }
//
//            //Step
//            if let count = stepCounts[Int(step)]{
//                stepCounts[Int(step)] = count + 1
//            }else{
//                stepCounts[Int(step)] = 1
//            }
//
//            print("User ID: \(userId)")
//            print("Name: \(name)")
//            print("Surname: \(surname)")
//            print("Birth Date: \(birthDate)")
//            print("Type: \(type)")
//            print("Color: \(color)")
//            print("To Be: \(toBe)")
//            print("Percent: \(percent)")
//            print("Step: \(step)")
//            print("----------")
//        }
//        // Type
//        for (type, count) in typeCounts {
//                print("\(count) kişi \(getTypeName(type)) seçeneğini seçti.")
//            }
//
//        // Color
//        for (color, count) in colorCounts {
//                print("\(count) kişi \(color) rengini seçti.")
//            }
//
//        // ToBe
//        print("\(toBeCount) kişi 'toBe' seçeneğini seçti.")
//        print("\(notToBeCount) kişi 'notToBe' seçeneğini seçti.")
//
//        // Percent
//        for (group, count) in groupPercentCounts {
//                print("\(count) kişi \(group) aralığında seçim yaptı.")
//            }
//
//        // Step
//        for (step, count) in stepCounts {
//            print("\(count) kişi \(step). adımda seçim yaptı.")
//        }
//
//    }
//
//    func getTypeName(_ type: Int) -> String {
//        switch type {
//        case 1:
//            return "Poem"
//        case 2:
//            return "Song"
//        case 3:
//            return "Picture"
//        default:
//            return ""
//        }
//    }
    
    func addListeners(){
        dataController.dataResults
            .receive(on: DispatchQueue.main)
            .sink { [weak self] statics in
                guard let statics = statics else {
                    return
                }// 158-160 optionaldan kurtarır
               var surveyDataPresentation = SurveyDataResultsPresentation()
                surveyDataPresentation.numberOfChooseBlackColor = "\(statics.numberOfChooseBlackColor) kişi siyah seçti"
                surveyDataPresentation.numberOfChooseBlueColor = "\(statics.numberOfChooseBlueColor) kişi mavi seçti"
                surveyDataPresentation.numberOfChoosePurpleColor = "\(statics.numberOfChoosePurpleColor) kişi mor seçti"
                surveyDataPresentation.numberOfChooseWhiteColor = "\(statics.numberOfChooseWhiteColor) kişi beyaz seçti"
                // optimistic value
                surveyDataPresentation.optimisticLevel20 = "\(statics.percentLevel20) kişi %0-20 arasında bir değer seçti"
                surveyDataPresentation.optimisticLevel40 = "\(statics.percentLevel40) kişi %20-40 arasında bir değer seçti"
                surveyDataPresentation.optimisticLevel60 = "\(statics.percentLevel60) kişi %40-60 arasında bir değer seçti"
                surveyDataPresentation.optimisticLevel80 = "\(statics.percentLevel80) kişi %60-80 arasında bir değer seçti"
                surveyDataPresentation.optimisticLevel100 = "\(statics.percentLevel100) kişi %80-100 arasında bir değer seçti"
                //ToBe
                surveyDataPresentation.selectToBe = "\(statics.toBeCount) kişi toBe seçti"
                surveyDataPresentation.selectNotToBe = "\(statics.notToBeCount) kişi NotToBe seçti"
                // Step
                surveyDataPresentation.stepValue3 =
                "\(statics.succesStep3) kişi 0-3 arası değer seçti"
                surveyDataPresentation.stepValue8 =
                "\(statics.succesStep8) kişi 3-8 arası değer seçti"
                surveyDataPresentation.stepValue8Plus =
                "\(statics.succesStep8Plus) kişi 8den yüksek değer seçti"
                // Type
                surveyDataPresentation.poemType = "\(statics.typePoem) kişi şiir seçti"
                surveyDataPresentation.songType = "\(statics.typeSong) kişi şarkı seçti"
                surveyDataPresentation.picturType = "\(statics.typePicture) kişi resim seçti"
                self?.surveyDataResultsPresentation = surveyDataPresentation
            }
            .store(in: &cancellables)
    }
    
    func initialize(){
        dataController.statistics()
    }
    
}

