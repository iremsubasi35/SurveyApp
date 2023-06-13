//
//  ResultView.swift
//  Survey
//
//  Created by Irem Subası on 5.06.2023.
//

import SwiftUI

struct ResultsView: View {
    @ObservedObject private var viewModel: ResultsViewModel
    init(viewModel: ResultsViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        VStack{
            Text("Color Results").bold()
                .padding(.bottom,10)
            Text(viewModel.surveyDataResultsPresentation.numberOfChooseWhiteColor)
            Text(viewModel.surveyDataResultsPresentation.numberOfChooseBlueColor)
            Text(viewModel.surveyDataResultsPresentation.numberOfChoosePurpleColor)
            Text(viewModel.surveyDataResultsPresentation.numberOfChooseBlackColor)
        }.padding(.vertical,16)
        VStack{
            Text("Optimistic Value Results").bold()
                .padding(.bottom,10)
            Text(viewModel.surveyDataResultsPresentation.optimisticLevel20)
            Text(viewModel.surveyDataResultsPresentation.optimisticLevel40)
            Text(viewModel.surveyDataResultsPresentation.optimisticLevel60)
            Text(viewModel.surveyDataResultsPresentation.optimisticLevel80)
            Text(viewModel.surveyDataResultsPresentation.optimisticLevel100)
        }.padding(.bottom,16)
        VStack{
            Text("Select ToBe Results").bold()
            Text(viewModel.surveyDataResultsPresentation.selectToBe)
            Text(viewModel.surveyDataResultsPresentation.selectNotToBe)
        }.padding(.bottom,16)
        VStack{
            Text("Succes Step Results").bold()
            Text(viewModel.surveyDataResultsPresentation.stepValue3)
            Text(viewModel.surveyDataResultsPresentation.stepValue8)
            Text(viewModel.surveyDataResultsPresentation.stepValue8Plus)
        }.padding(.bottom,16)
        VStack{
            Text("Type Results").bold()
            Text(viewModel.surveyDataResultsPresentation.poemType)
            Text(viewModel.surveyDataResultsPresentation.songType)
            Text(viewModel.surveyDataResultsPresentation.picturType)
        }.padding(.bottom,16)
        .onAppear {
            viewModel.initialize()
               }
    }
}


