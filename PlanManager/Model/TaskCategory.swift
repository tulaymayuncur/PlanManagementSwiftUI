//
//  TaskCategory.swift
//  PlanManager
//
//  Created by Tülay MAYUNCUR on 24.04.2023.
//

import SwiftUI

// MARK: Category Enum with Color

enum Category: String,CaseIterable{
    
    case general = "General"
    case bug = "Bug"
    case idea = "Idea"
    case modifiers = "Modifiers"
    case challenge = "Challenge"
    case coding = "Coding"
    
    var color: Color{
        
        switch self {
        case .general:
            return Color.gray
            
        case .bug:
            return Color.green
            
        case .idea:
            return Color.pink
            
        case .modifiers:
            return Color.blue
            
        case .challenge:
            return Color.purple
            
        case .coding:
            return Color.brown
            
        }
    }
}
