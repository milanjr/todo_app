//
//  TaskManager.swift
//  Todo App
//
//  Created by Milan Rathod on 24/11/25.
//

import SwiftData
import Foundation
import Combine

@MainActor
class TaskManager: ObservableObject {
  
  var context: ModelContext
  
  init(context: ModelContext) {
    self.context = context
  }
  
  // MARK: - Create Task
  func createTask(title: String,
                  dueDate: Date? = nil,
                  notes: String? = nil,
                  importance: Importance = .notImportant,
                  status: Status = .notPlanned) {
    
    let task = TodoTask(
      creationDate: .now,
      dueDate: dueDate,
      title: title,
      notes: notes,
      importance: importance,
      status: status
    )
    
    context.insert(task)
    do {
        try context.save()
    } catch {
        print("Failed to save task: \(error)")
    }
    debugPrint("TaskManager - createTask \(task.creationDate)")
  }
  
  // MARK: - Update Due Date
  func setDueDate(for task: TodoTask, dueDate: Date?) {
    task.dueDate = dueDate
  }
  
  // MARK: - Update Notes
  func setNotes(for task: TodoTask, notes: String?) {
    task.notes = notes
  }
  
  // MARK: - Update Status
  func setStatus(for task: TodoTask, status: Status) {
    task.status = status
  }
  
  
//  // MARK: - Eisenhower Matrix Lists
//  @Query(filter: #Predicate<TodoTask> {
//      $0.importance == .important &&
//      $0.urgency == .urgent
//  })
//  var importantUrgent: [TodoTask]
//
//  var importantNotUrgent: [TodoTask] {
//    let descriptor = FetchDescriptor<TodoTask>(predicate: #Predicate {
//      $0.importance == .important &&
//      //            ($0.dueDate == nil || $0.dueDate! > Date())
//      $0.urgency == .notUrgent
//    })
//    return (try? context.fetch(descriptor)) ?? []
//  }
//  
//  var notImportantUrgent: [TodoTask] {
//    let descriptor = FetchDescriptor<TodoTask>(predicate: #Predicate {
//      $0.importance == .notImportant &&
//      $0.dueDate != nil &&
//      $0.urgency == .urgent
//    })
//    return (try? context.fetch(descriptor)) ?? []
//  }
//  
//  var notImportantNotUrgent: [TodoTask] {
//    let descriptor = FetchDescriptor<TodoTask>(predicate: #Predicate {
//      $0.importance == .notImportant &&
//      $0.urgency == .notUrgent
//    })
//    return (try? context.fetch(descriptor)) ?? []
//  }
//  
//  // MARK: - Fetch All Tasks
//  private var tasks: [TodoTask] {
//    let descriptor = FetchDescriptor<TodoTask>(sortBy: [
//      SortDescriptor(\.creationDate, order: .reverse)
//    ])
//    
//    return (try? context.fetch(descriptor)) ?? []
//  }
}

