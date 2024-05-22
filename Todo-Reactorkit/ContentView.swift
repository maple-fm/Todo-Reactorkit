//
//  ContentView.swift
//  Todo-Reactorkit
//
//  Created by 出口楓真 on 2024/05/14.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var store: TaskReactor
    
    init(store: TaskReactor = TaskReactor()) {
        self.store = store
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.currentState.tasks, id: \.id) { task in
                    NavigationLink(destination: TaskDetailView(store: store, task: task)) {
                        HStack {
                            TaskRow(task: task)
                        }
                    }
                }
            }
            .navigationTitle("TODO")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        store.action.onNext(.addTask("新しいタスク"))
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .onAppear {
            store.action.onNext(.load)
            print("タスク: \(store.currentState.tasks)")
        }
    }
}

#Preview {
    ContentView()
}

struct TaskRow: View {
    let task: Task
    
    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
            Text(task.title)
        }
    }
}

struct TaskDetailView: View {
    var store: TaskReactor
    @State var task: Task
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            TextField("タイトル", text: $task.title)
            Toggle("完了", isOn: $task.isCompleted)
        }
        .navigationTitle(task.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    store.action.onNext(.delete(task.id))
                    dismiss()
                }) {
                    Image(systemName: "trash")
                }
            }
        }
    }
}
