//
//  SurveyViewModel.swift
//  Survey
//
//  Created by Irem Subası on 25.05.2023.
//

import SwiftUI
import Combine

struct UserInformationPresentation: Identifiable{
    let id: UUID = .init()
    var userId: Int?
    var userIdText: String = "" {
        didSet
        {
            let filtered = userIdText.filter { $0.isNumber }
            if userIdText != filtered {
                userIdText = filtered
            }
        }
    }
    var name: String = ""
    var surname: String = ""
    var birthDate: Date = .now
    var type: Int = 1
    var color: String = "White"
    var toBe: Bool = false
    var percent : Float = 0.0
    var step : Int = 0
}

final class SurveyViewModel: ObservableObject {
    
    private let dataController: SurveyDataController
    
    @Published var userInformationPresentation: UserInformationPresentation = .init()
    @Published var buttonInvalid: Bool = true
    @Published var checkProcess: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private(set) var answerOfSurveyPresentation = CurrentValueSubject<UserInformationPresentation?, Never>(nil)

    init(dataController: SurveyDataController) {
        self.dataController = dataController
        addListeners()
    }
    
    func addListeners(){
        dataController.currentState
                        .receive(on: DispatchQueue.main)
                        .sink { [weak self]  state in
                            guard let self = self else {
                                return
                            }
                            print("\(state)")
                            self.processControlPresentation()
                        }
                        .store(in: &cancellables) // yazılmassa kendini yok eder
        $userInformationPresentation.receive(on: DispatchQueue.main)
            .sink { presentation in
                self.validationPresentation()
            }
            .store(in: &cancellables)
    }

    func actionSubmit(){
        guard let userId = Int(userInformationPresentation.userIdText) else {
            return
        }
        dataController.saveResult(userId: userId, name: userInformationPresentation.name, surname: userInformationPresentation.surname, birthDate: userInformationPresentation.birthDate, type: userInformationPresentation.type, color: userInformationPresentation.color, toBe: userInformationPresentation.toBe, percent: userInformationPresentation.percent, step: userInformationPresentation.step )
    }
    
    func processControlPresentation(){
            if dataController.currentState.value == .working {
                checkProcess = true
            } else {
                checkProcess = false
            }
    }
    
    
    func validationPresentation(){
        buttonInvalid = false
        if userInformationPresentation.userIdText.isEmpty {
            buttonInvalid = true
        }
        if userInformationPresentation.name.isEmpty {
            buttonInvalid = true
        }
        if userInformationPresentation.surname.isEmpty {
            buttonInvalid = true
        }
    }
}


