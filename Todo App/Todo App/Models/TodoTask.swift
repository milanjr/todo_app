//
//  Task.swift
//  Todo App
//
//  Created by Milan Rathod on 24/11/25.
//

import SwiftData
import Foundation

@Model
class TodoTask {
  // MARK: - Stored Properties
  var creationDate: Date
  var dueDate: Date?
  var title: String
  var notes: String?
  var status: Status

  var importance: Importance
//  {
//    get { Importance(rawValue: importanceRaw) ?? .notImportant } // Default to .other if rawValue is invalid
//    set { importanceRaw = newValue.rawValue }
//  }

  var urgency: Urgency
//  {
//    get { Urgency(rawValue: urgencyRaw) ?? .notUrgent } // Default to .other if rawValue is invalid
//    set { urgencyRaw = newValue.rawValue }
//  }
  
//  var urgencyRaw: Int
//  var importanceRaw: Int

  // MARK: - Initializer
  init(
    creationDate: Date = .now,
    dueDate: Date? = nil,
    title: String,
    notes: String? = nil,
    importance: Importance = .notImportant,
    status: Status = .notPlanned,
    urgency: Urgency = .notUrgent
  ) {
//    self.urgencyRaw = 0
//    self.importanceRaw = 0

    self.creationDate = creationDate
    self.dueDate = dueDate
    self.title = title
    self.notes = notes
    self.status = status

    self.importance = importance
    self.urgency = urgency
  }
}

extension TodoTask {
    static func importantAndUrgentPredicate() -> Predicate<TodoTask> {
        #Predicate<TodoTask> { task in
          task.importance.rawValue == 1 && task.urgency.rawValue == 1
        }
    }
}
