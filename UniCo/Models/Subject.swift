//
//  Item.swift
//  UniCo
//
//  Created by Tianpeng Gou on 8/9/2024.
//

import Foundation

struct Subject: Codable, Identifiable {
    let id: String
    let code: String
    let title: String
    let selectedYear: String
    let selectedSession: String
    var isDone: Bool  // will be used later
    
    
    // will be used later
    mutating func setDone (_ state: Bool) {
        isDone = state
    }
}
