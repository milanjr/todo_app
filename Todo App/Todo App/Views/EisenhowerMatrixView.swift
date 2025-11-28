//
//  EisenhowerMatrixView.swift
//  Todo App
//
//  Created by Milan Rathod on 24/11/25.
//

import SwiftUI
import SwiftData

struct EisenhowerMatrixView: View {
  @Environment(\.modelContext) private var context
  @State private var viewModel: EisenhowerMatrixViewModel?
  
  // @FetchRequest for importantUrgent, importantNotUrgent, notImportantUrgent and notImportantNotUrgent
  // Important + Urgent
  @Query var importantUrgent: [TodoTask]
  @Query var importantNotUrgent: [TodoTask]
  @Query var notImportantUrgent: [TodoTask]
  @Query var notImportantNotUrgent: [TodoTask]
  
//  @Query(filter: #Predicate<TodoTask> { task in
////    task.importance.rawValue == 1 &&
//    task.urgency.rawValue == 1
//  })
//  var importantUrgent1: [TodoTask]

  @Query(filter: TodoTask.importantAndUrgentPredicate())
  var importantUrgent1: [TodoTask]
  
  
//  // Important + Not Urgent
//  @Query(filter: #Predicate<TodoTask> { task in
////    task.importance == Importance.important &&
//    task.urgency == Urgency.notUrgent
//  })
//  var importantNotUrgent: [TodoTask]
//  
//  // Not Important + Urgent
//  @Query(filter: #Predicate<TodoTask> { task in
////    task.importance == Importance.notImportant &&
//    task.urgency == Urgency.urgent
//  })
//  var notImportantUrgent: [TodoTask]
//  
//  // Not Important + Not Urgent
//  @Query(filter: #Predicate<TodoTask> { task in
////    task.importance == Importance.notImportant &&
//    task.urgency == Urgency.notUrgent
//  })
//  var notImportantNotUrgent: [TodoTask]
  
  
  var body: some View {
    VStack {
      if viewModel == nil {
        Text("Loading...")
      } else {
        VStack(spacing: 10) {
          if let viewModel = viewModel {
            SearchHeaderView(viewModel: viewModel)
//            HStack {
//              Text("Search...")
//              Spacer()
//              Button(action: {
//                debugPrint("Add button")
//                viewModel.addSampleTask()
//              }, label: {
//                Image(systemName: "plus")
//                  .frame(width: 30, height: 30)
//                  .background(.white)
//                  .cornerRadius(15)
//                  .shadow(radius: 5)
//              })
//            }
            
            HStack {
              MatrixCardView(tasks: importantUrgent, title: "Very Urgent", color: Color("UrgentImp"))
              MatrixCardView(tasks: notImportantUrgent, title: "Urgent", color: Color("NotUrgentImp"))
            }
            
            HStack {
              MatrixCardView(tasks: importantNotUrgent, title: "Important", color: Color("UrgentNotImp"))
              MatrixCardView(tasks: notImportantNotUrgent, title: "Hmmm", color: Color("NotUrgentNotImp"))
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
  let viewModel: EisenhowerMatrixViewModel
  
  var body: some View {
    HStack {
//      Text("Search")
      Spacer()
      Button(action: {
        debugPrint("Add button")
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
  let tasks: [TodoTask]
  let title: String
  let color: Color
  
  var body: some View {
    ZStack {
      Rectangle()
        .fill(color)
      VStack(spacing: 10) {
        HStack {
          Spacer()
          Text(title)
            .lineLimit(1)
            .bold()
          Text("(\(tasks.count))")
          Spacer()
        }
        .padding(10)
        .background(color)
        .cornerRadius(10)
        .shadow(radius: 5)

        VStack(spacing: 5) {
          ForEach(Array(tasks.prefix(5))) {task in
            MatrixCardRowView(task: task)
              .padding(.horizontal, 5)
              .background(.white.opacity(0.5))
              .cornerRadius(5)
//              .shadow(radius: 5)
          }
          Spacer()
        }
        .background(color)
      }
      .padding(3)
//      .background(color)
    }
    .cornerRadius(10)
    .shadow(radius: 5)
  }
}

struct MatrixCardRowView: View {
  let task: TodoTask
  
  var body: some View {
    HStack {
      Text("\(task.title)")
      Spacer()
    }
    .padding(5)
  }
}

#Preview {
  let preview = Preview()

  EisenhowerMatrixView()
    .modelContainer(preview.modelContainer)
    .padding(.horizontal, 16)
}

