//
//  SurveyAppApp.swift
//  SurveyApp
//
//  Created by Irem Subası on 8.06.2023.
//

import SwiftUI

@main
struct SurveyApp: App {
    private let surveyView: SurveyView = {
        let dataController = SurveyDataController()
        let viewModel = SurveyViewModel(dataController: dataController)
        let view = SurveyView(viewModel: viewModel)
        return view
    }()
    var body: some Scene {
        WindowGroup {
            surveyView
        }
    }
}
