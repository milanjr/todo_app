//
//  EisenhowerMatrixViewModel.swift
//  Todo App
//
//  Created by Milan Rathod on 24/11/25.
//

import Foundation
import SwiftData
import Combine


@MainActor
final class EisenhowerMatrixViewModel: ObservableObject {
  

    let taskManager: TaskManager

    init(context: ModelContext) {
        self.taskManager = TaskManager(context: context)
    }

    func addSampleTask() {
      debugPrint("EisenhowerMatrixViewModel - addSampleTask")
        taskManager.createTask(title: "Sample")
    }
}

