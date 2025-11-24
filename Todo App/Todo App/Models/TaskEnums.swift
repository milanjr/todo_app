//
//  TaskEnums.swift
//  Todo App
//
//  Created by Milan Rathod on 24/11/25.
//

import Foundation

enum Urgency {
    case urgent
    case notUrgent
}

enum Importance: String, Codable {
    case important
    case notImportant
}

enum Status: String, Codable {
    case notPlanned
    case planned
    case inProgress
    case onHold
    case done
    case canceled
}
