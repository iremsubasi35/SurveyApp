//
//  ContentView.swift
//  Survey
//
//  Created by Irem Subası on 25.05.2023.
//

import SwiftUI


struct SurveyView: View {
    @ObservedObject private var viewModel: SurveyViewModel
    @State private var showResults = false
    
    init(viewModel: SurveyViewModel) {
        self.viewModel = viewModel
    }
    
    private  let colorChoose = ["White","Purple","Blue","Black"]
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    VStack{
                        HStack{
                            Text("Your id:").foregroundColor(Color.black)
                            TextField("", text: $viewModel.userInformationPresentation.userIdText)
                                .textFieldStyle(.roundedBorder)
                        }
                        HStack{
                            Text("Your name:").foregroundColor(Color.black)
                            TextField("", text: $viewModel.userInformationPresentation.name)
                                .textFieldStyle(.roundedBorder)
                        }
                        HStack{
                            Text("Your surname:").foregroundColor(Color.black)
                            TextField("", text: $viewModel.userInformationPresentation.surname)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        HStack{
                            HStack {
                                DatePicker("Your date of birth:", selection: $viewModel.userInformationPresentation.birthDate, in: ...Date(), displayedComponents: [.date])
                            }
                        }
                    }
                    .padding(.horizontal,30)
                    .onChange(of: viewModel.userInformationPresentation.percent){ value in
                        if value >= 70{
                            viewModel.userInformationPresentation.color = "Red"
                        }
                    }
                    Form{
                        Section{
                            Text("If you were a work of art, which would you be?")
                            Picker(selection: $viewModel.userInformationPresentation.type, label: Text("Picker")) {
                                Text("Poem").tag(1)
                                Text("Song").tag(2)
                                Text("Picture").tag(3)
                            }.pickerStyle(SegmentedPickerStyle())
                            
                            Picker("Which color reflects you?",selection: $viewModel.userInformationPresentation.color){
                                ForEach(colorChoose, id: \.self){
                                    Text($0)
                                }
                            }
                            
                            Text("I am \( Int(viewModel.userInformationPresentation.percent) )% optimistic")
                            Slider(value: $viewModel.userInformationPresentation.percent, in: 0...100)
                            
                            
                            Toggle("To be or Not to be ?", isOn: $viewModel.userInformationPresentation.toBe)
                            
                            Text("How many steps are left before you succeed?")
                            Stepper(value: $viewModel.userInformationPresentation.step, in: 0...10) {
                                Text("\(self.viewModel.userInformationPresentation.step) steps to my goal")
                            }
                        }
                    }
                    Button(action: {
                        viewModel.actionSubmit()
                    }) {
                        Text("submit")
                            .foregroundColor(Color.black)
                            .opacity(viewModel.buttonInvalid ? 0.5 : 1.0)
                    }
                    .disabled(viewModel.buttonInvalid)
                    
                }
                if viewModel.checkProcess {
                    Color.gray.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                    ProgressView()
                }
            }
            .sheet(isPresented: $showResults) {
                ResultsView(viewModel: ResultsViewModel(dataController: ResultsDataController()))
                        }
            .navigationBarItems(trailing:
                            Button(action: {
                                showResults = true
                            }) {
                                Text("Results")
                            }
                        )
        }

       
    }
}



