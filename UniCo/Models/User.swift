//
//  User.swift
//  UniCo
//
//  Created by Tianpeng Gou on 8/9/2024.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
