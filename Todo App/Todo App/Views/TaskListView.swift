//
//  TaskListView.swift
//  Todo App
//
//  Created by Milan Rathod on 24/11/25.
//

import SwiftUI
import SwiftData

struct TaskListView: View {
  @Environment(\.modelContext) private var context
  @State private var viewModel: EisenhowerMatrixViewModel?

  // @FetchRequest for importantUrgent, importantNotUrgent, notImportantUrgent and notImportantNotUrgent
  // Important + Urgent
  @Query var tasks: [TodoTask]
  
  var body: some View {
//    VStack {
//      if let viewModel = viewModel {
//        SearchHeaderView(viewModel: viewModel)
//          .padding(10)
//      }
    NavigationView {
        
        List {
          ForEach(tasks) {task in
            TaskListRowView(task: task)
          }
        }
        .navigationTitle("All tasks")
        .toolbar {
          ToolbarItem(placement: .primaryAction) {
            Button(action: {
              viewModel?.addSampleTask()
            }) {
              Image(systemName: "plus")
            }
          }
        }
      }
//    }
    .onAppear {
          if viewModel == nil {
            viewModel = EisenhowerMatrixViewModel(context: context)
          }
        }
  }
}

struct TaskListRowView: View {
  let task: TodoTask
  
  fileprivate func color(for status: Status) -> Color {
    var color: Color = .gray
    switch status {
    case .planned:
      color = .yellow
    case .inProgress:
      color = .blue
    case .done:
      color = .green
    case .onHold:
      color = .orange
    case .notPlanned, .canceled:
      color = .gray
    @unknown default:
      color = .gray
    }
    return color
  }
  
  var body: some View {
    VStack {
      HStack {
        Circle()
          .fill(color(for: task.status))
          .frame(width: 15, height: 15)

        Text("\(task.title)")
        Spacer()
        
        if task.importance == .important {
          Image(systemName: "info.circle")
            .tint(Color(.systemBlue))
        }

        if task.urgency == .urgent {
          Image(systemName: "arrow.up")
            .tint(Color(.systemBlue))
        }

        if let dueDate = task.dueDate/*, dueDate > Date()*/ {
          //        Text(dueDate.formatted(date: .numeric, time: .omitted))
          //        Text(dueDate, format: Date.FormatStyle(date: .abbreviated, time: .omitted))
          Text(dueDate, format: Date.FormatStyle().day().month())
        } else {
          Image(systemName: "calendar")
        }
      }
      
//      HStack {
//        Circle()
//          .fill(color(for: task.status))
//          .frame(width: 15, height: 15)
//        
//        Spacer()
//        
//        if task.importance == .important {
//          Image(systemName: "info")
//            .tint(Color(.systemBlue))
//        }
//
//        if task.urgency == .urgent {
//          Image(systemName: "arrow.up")
//            .tint(Color(.systemBlue))
//        }
//      }
    }
//    .padding(10)
    .background(.white)
//    .cornerRadius(10)
//    .shadow(radius: 5)
  }
}

#Preview {
  let preview = Preview()

  TaskListView()
    .modelContainer(preview.modelContainer)
//    .padding(.horizontal, 16)
}
