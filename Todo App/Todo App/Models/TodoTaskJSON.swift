//
//  TodoTaskJSON.swift
//  Todo App
//
//  Created by Milan Rathod on 26/11/25.
//

import Foundation
import SwiftData

struct TodoTaskJSON: Codable {
    let creationDate: Date
    let dueDate: Date?
    let title: String
    let notes: String?
    let status: Int
    let importance: Int
    let urgency: Int
}

class JSONTaskLoader {

    static func loadTasks(into context: ModelContext) {
        guard let url = Bundle.main.url(forResource: "todo_tasks", withExtension: "json") else {
            print("❌ todo_tasks.json not found in bundle.")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            let jsonTasks = try decoder.decode([TodoTaskJSON].self, from: data)

            for item in jsonTasks {

                guard let status = Status(rawValue: item.status),
                      let importance = Importance(rawValue: item.importance),
                      let urgency = Urgency(rawValue: item.urgency) else {
                    print("⚠️ Invalid enum raw value encountered, skipping one item.")
                    continue
                }

                let task = TodoTask(
                    creationDate: item.creationDate,
                    dueDate: item.dueDate,
                    title: item.title,
                    notes: item.notes,
                    importance: importance,
                    status: status,
                    urgency: urgency
                )

                context.insert(task)
            }

            try context.save()
            print("✅ Successfully loaded tasks into SwiftData.")

        } catch {
            print("❌ Failed to load tasks from JSON:", error)
        }
    }
}
