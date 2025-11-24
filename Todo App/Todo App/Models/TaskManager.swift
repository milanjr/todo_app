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
    
    let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    // MARK: - Create Task
    func createTask(title: String,
                    dueDate: Date? = nil,
                    notes: String? = nil,
                    importance: Importance = .notImportant,
                    status: Status = .notPlanned) {
        
        let task = Task(
            creationDate: .now,
            dueDate: dueDate,
            title: title,
            notes: notes,
            importance: importance,
            status: status
        )
        
        context.insert(task)
    }
    
    // MARK: - Update Due Date
    func setDueDate(for task: Task, dueDate: Date?) {
        task.dueDate = dueDate
    }
    
    // MARK: - Update Notes
    func setNotes(for task: Task, notes: String?) {
        task.notes = notes
    }
    
    // MARK: - Update Status
    func setStatus(for task: Task, status: Status) {
        task.status = status
    }
    
    
    // MARK: - Eisenhower Matrix Lists
    var importantUrgent: [Task] {
        tasks.filter { $0.importance == .important && $0.urgency == .urgent }
    }
    
    var importantNotUrgent: [Task] {
        tasks.filter { $0.importance == .important && $0.urgency == .notUrgent }
    }
    
    var notImportantUrgent: [Task] {
        tasks.filter { $0.importance == .notImportant && $0.urgency == .urgent }
    }
    
    var notImportantNotUrgent: [Task] {
        tasks.filter { $0.importance == .notImportant && $0.urgency == .notUrgent }
    }
    
    
    // MARK: - Fetch All Tasks
    private var tasks: [Task] {
        let descriptor = FetchDescriptor<Task>(sortBy: [
            SortDescriptor(\.creationDate, order: .reverse)
        ])
        
        return (try? context.fetch(descriptor)) ?? []
    }
}

