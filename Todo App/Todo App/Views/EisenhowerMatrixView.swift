//
//  EisenhowerMatrixView.swift
//  Todo App
//
//  Created by Milan Rathod on 24/11/25.
//

import SwiftUI

struct EisenhowerMatrixView: View {
  @Environment(\.modelContext) private var context
  @State private var viewModel: EisenhowerMatrixViewModel?
  
  var body: some View {
    VStack {
      if viewModel == nil {
        Text("Loading...")
      } else {
        VStack(spacing: 10) {
          if let viewModel = viewModel {
            SearchHeaderView(viewModel: viewModel)
            
            HStack {
              MatrixCardView(tasks: viewModel.taskManager.importantUrgent, title: "Very Urgent", color: Color("UrgentImp"))
              MatrixCardView(tasks: viewModel.taskManager.notImportantNotUrgent, title: "Urgent", color: Color("NotUrgentImp"))
            }
            
            HStack {
              MatrixCardView(tasks: viewModel.taskManager.importantNotUrgent, title: "Important", color: Color("UrgentNotImp"))
              MatrixCardView(tasks: viewModel.taskManager.notImportantNotUrgent, title: "Hmmm", color: Color("NotUrgentNotImp"))
            }
          }
          
        }
      }
    }
    .onAppear {
      if viewModel == nil {
        viewModel = EisenhowerMatrixViewModel(context: context)
      }
    }
  }
}

struct SearchHeaderView: View {
  @ObservedObject var viewModel: EisenhowerMatrixViewModel

  var body: some View {
    HStack {
      Text("Search")
      Spacer()
      Button(action: {
        viewModel.addSampleTask()
      }, label: {
        Image(systemName: "plus")
          .frame(width: 30, height: 30)
          .background(.white)
          .cornerRadius(15)
          .shadow(radius: 5)
      })
    }
  }
}

struct MatrixCardView: View {
  let tasks: [Task]
  let title: String
  let color: Color
  
  var body: some View {
    VStack {
      Text("\(title) - \(tasks.count)")
      Rectangle()
        .fill(color)
    }
    .background(.white)
    .cornerRadius(10)
    .shadow(radius: 5)
  }
}


#Preview {
  EisenhowerMatrixView()
    .padding(.horizontal, 20)
}

