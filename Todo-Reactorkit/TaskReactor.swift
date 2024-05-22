//
//  TaskStore.swift
//  Todo-Reactorkit
//
//  Created by 出口楓真 on 2024/05/14.
//

import Foundation
import ReactorKit

class TaskReactor: Reactor, ObservableObject {
    
    enum Action {
        case load
        case addTask(String)
        case toggleTaskCompletion(String)
    }
    
    enum Mutation {
        case setTasks([Task])
        case addTask(Task)
        case toggleTaskCompletion(String)
    }
    
    struct State {
        var tasks = [Task]()
    }
    
    let initialState: State
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            return .just(.setTasks([]))
        case .addTask(let title):
            let newTask = Task(id: UUID().uuidString, title: title, isCompleted: false)
            return .just(.addTask(newTask))
        case .toggleTaskCompletion(let id):
            return .just(.toggleTaskCompletion(id))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case.setTasks(let tasks):
            state.tasks = tasks
        case .addTask(let task):
            state.tasks.append(task)
            self.objectWillChange.send()
        case .toggleTaskCompletion(let id):
            if let index = state.tasks.firstIndex(where: { $0.id == id }) {
                state.tasks[index].isCompleted.toggle()
            }
        }
        return state
    }
    
}
