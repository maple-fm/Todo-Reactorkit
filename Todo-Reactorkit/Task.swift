//
//  Task.swift
//  Todo-Reactorkit
//
//  Created by 出口楓真 on 2024/05/14.
//

import Foundation

struct Task: Identifiable, Hashable {
    let id: String
    var title: String
    var isCompleted: Bool
    
    func hashValue() -> Int {
        id.hashValue ^ title.hashValue ^ isCompleted.hashValue
    }
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        lhs.id == rhs.id && lhs.title == rhs.title && lhs.isCompleted == rhs.isCompleted
    }
}
