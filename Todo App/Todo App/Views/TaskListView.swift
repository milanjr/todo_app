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
  
  // @FetchRequest for importantUrgent, importantNotUrgent, notImportantUrgent and notImportantNotUrgent
  // Important + Urgent
  @Query var tasks: [TodoTask]

  var body: some View {
        Text("Task List View")
    }
}

#Preview {
    TaskListView()
}
