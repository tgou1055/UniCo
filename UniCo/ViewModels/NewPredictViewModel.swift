//
//  newPredictViewModel.swift
//  UniCo
//
//  Created by Tianpeng Gou on 16/9/2024.
//

import Foundation

class NewPredictViewModel: ObservableObject {
    @Published var expectedGrade = "50"
    
    init() {}
    
    var canSave: Bool {
        return true
    }
    
    func save() {
        
    }
}
