//
//  PlaygroundView.swift
//  Todo App
//
//  Created by Milan Rathod on 25/11/25.
//

import SwiftUI
import SwiftData

struct PlaygroundView: View {
  @Environment(\.modelContext) private var context
  
  @Query var importantUrgent: [TodoTask]
  
  var body: some View {
    VStack {
      Text("Important and Urgent Tasks")
        .font(.largeTitle)
      
      Button("Add Task") {
        do {
          context.insert(TodoTask(title: "New Task"))
          try context.save()
        } catch {
          print("Failed to save task: \(error)")
        }
        debugPrint("Added a task")
      }
      
      List(importantUrgent) { task in
        Text(task.title)
      }
    }
  }
}


struct Preview {
    
    let modelContainer: ModelContainer
    init() {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        do {
            modelContainer = try ModelContainer(for: TodoTask.self, configurations: config)
          
          JSONTaskLoader.loadTasks(into: modelContainer.mainContext)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
  func firstTask() -> TodoTask {
      let context = modelContainer.mainContext
      let descriptor = FetchDescriptor<TodoTask>(sortBy: [SortDescriptor(\.creationDate)])
      
      return (try? context.fetch(descriptor).first) ?? TodoTask(
          creationDate: Date(),
          dueDate: nil,
          title: "Sample Task",
          notes: nil,
          importance: .important,
          status: .planned,
          urgency: .urgent
      )
  }

//    func addExamples(_ examples: [GroceryItem]) {
//        
//        Task { @MainActor in
//            examples.forEach { example in
//                modelContainer.mainContext.insert(example)
//            }
//        }
//        
//    }
}


#Preview {
  let preview = Preview()
  
  PlaygroundView()
    .modelContainer(preview.modelContainer)
}
