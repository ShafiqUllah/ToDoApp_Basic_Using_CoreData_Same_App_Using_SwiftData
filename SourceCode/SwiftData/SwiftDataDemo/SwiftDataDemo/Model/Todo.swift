//
//  TodoModel.swift
//  SwiftDataDemo
//
//  Created by test on 11/7/24.
//

import Foundation
import SwiftData

@Model
class Todo{
    var title: String
    var isComepte :Bool
    
    init(title: String, isComepte: Bool) {
        self.title = title
        self.isComepte = isComepte
    }
}
