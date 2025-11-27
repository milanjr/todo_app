//
//  TaskEnums.swift
//  Todo App
//
//  Created by Milan Rathod on 24/11/25.
//

import Foundation

enum Urgency: Int, Codable {
  case notUrgent = 0
  case urgent = 1
}

enum Importance: Int, Codable {
  case notImportant
  case important
}

enum Status: Int, Codable {
  case notPlanned
  case planned
  case inProgress
  case onHold
  case done
  case canceled
}
