//
//  TaskEditView.swift
//  Todo App
//
//  Created by Milan Rathod on 26/11/25.
//

import SwiftUI
import SwiftData

struct TaskEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @Bindable var task: TodoTask

    @State private var showDatePicker = false

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Title")) {
                    TextField("Enter task title", text: $task.title)
                }

                Section(header: Text("Notes")) {
                    TextEditor(text: Binding($task.notes, replacingNilWith: ""))
                        .frame(minHeight: 120)
                }

                Section(header: Text("Due Date")) {
                    Toggle("Set Due Date", isOn: Binding(
                        get: { task.dueDate != nil },
                        set: { hasDate in
                            task.dueDate = hasDate ? Date() : nil
                        }
                    ))

                    if task.dueDate != nil {
                        DatePicker(
                            "Due Date",
                            selection: Binding($task.dueDate, replacingNilWith: Date()),
                            displayedComponents: [.date, .hourAndMinute]
                        )
                    }
                }

                Section(header: Text("Priority")) {
                    Picker("Urgency", selection: $task.urgency) {
                        Text("Not Urgent").tag(Urgency.notUrgent)
                        Text("Urgent").tag(Urgency.urgent)
                    }
                    .pickerStyle(.segmented)

                    Picker("Importance", selection: $task.importance) {
                        Text("Not Important").tag(Importance.notImportant)
                        Text("Important").tag(Importance.important)
                    }
                    .pickerStyle(.segmented)
                }

                Section(header: Text("Status")) {
                    Picker("Status", selection: $task.status) {
                        Text("Not Planned").tag(Status.notPlanned)
                        Text("Planned").tag(Status.planned)
                        Text("In Progress").tag(Status.inProgress)
                        Text("On Hold").tag(Status.onHold)
                        Text("Done").tag(Status.done)
                        Text("Canceled").tag(Status.canceled)
                    }
                }
            }
            .navigationTitle("Edit Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        saveAndClose()
                    }
                    .bold()
                }
            }
        }
    }

    private func saveAndClose() {
        do {
            try context.save()
            dismiss()
        } catch {
            print("❌ Failed to save:", error)
        }
    }
}

extension Binding {
    init(_ source: Binding<Value?>, replacingNilWith defaultValue: Value) {
        self.init(
            get: { source.wrappedValue ?? defaultValue },
            set: { newValue in source.wrappedValue = newValue }
        )
    }
}


#Preview {
    let preview = Preview()
    return TaskEditView(task: preview.firstTask())
        .modelContainer(preview.modelContainer)
}
