//
//  Task.swift
//  Todo App
//
//  Created by Milan Rathod on 24/11/25.
//

import SwiftData
import Foundation

@Model
class Task {
    // MARK: - Stored Properties
    var creationDate: Date
    var dueDate: Date?
    var title: String
    var notes: String?
    var importance: Importance
    var status: Status

    // MARK: - Computed Property (Not Persisted)
    var urgency: Urgency {
        if let due = dueDate {
            // You can customize the logic here
            return Calendar.current.isDateInToday(due) ||
                   due < Date()
                   ? .urgent
                   : .notUrgent
        }
        return .notUrgent
    }

    // MARK: - Initializer
    init(
        creationDate: Date = .now,
        dueDate: Date? = nil,
        title: String,
        notes: String? = nil,
        importance: Importance = .notImportant,
        status: Status = .notPlanned
    ) {
        self.creationDate = creationDate
        self.dueDate = dueDate
        self.title = title
        self.notes = notes
        self.importance = importance
        self.status = status
    }
}
