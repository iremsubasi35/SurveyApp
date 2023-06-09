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
            
        }
        .onAppear {
            viewModel.processData()
               }
    }
}


