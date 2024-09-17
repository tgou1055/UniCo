//
//  Task.swift
//  UniCo
//
//  Created by Tianpeng Gou on 11/9/2024.
//

import Foundation

struct Task: Codable, Identifiable {
    let id: String
    let type: String
    let title: String
    let dueDate: TimeInterval // fix later
    let weighting: String
    let mark: String
    let score: String
    
    var isDone: Bool  // will be used later
    
    
    // will be used later
    mutating func setDone (_ state: Bool) {
        isDone = state
    }
}
