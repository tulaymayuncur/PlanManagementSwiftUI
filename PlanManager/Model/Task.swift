//
//  Task.swift
//  PlanManager
//
//  Created by Tülay MAYUNCUR on 24.04.2023.
//

import SwiftUI

// MARK: Task Model

struct Task: Identifiable {
    let id: UUID = .init()
    let dateAdded: Date
    let taskName: String
    let taskDescription: String
    let taskCategory: Category
}

var sampleTasks: [Task] = [
    Task(dateAdded: Date(timeIntervalSince1970: 1672829809),
         taskName: "Edit YT Video",
         taskDescription: "",
         taskCategory: .general),
    
    Task(dateAdded: Date(timeIntervalSince1970: 1672833409),
         taskName: "Matched Geometry Effect (Issue)",
         taskDescription: "",
         taskCategory: .bug),
    
    Task(dateAdded: Date(timeIntervalSince1970: 1672833409),
         taskName: "Multi-ScrollView",
         taskDescription: "",
         taskCategory: .challenge),
    
    Task(dateAdded: Date(timeIntervalSince1970: 1672837009),
         taskName: "Lorem Ipsum",
         taskDescription: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Since the 1500s.",
         taskCategory: .idea),
    
    Task(dateAdded: Date(timeIntervalSince1970: 1672714609),
         taskName: "Complete UI Animation Challenge",
         taskDescription: "",
         taskCategory: .challenge),
    
    Task(dateAdded: Date(timeIntervalSince1970: 1672851409),
         taskName: "Fix Shadow Issue on Mockups",
         taskDescription: "",
         taskCategory: .bug),
    
    Task(dateAdded: Date(timeIntervalSince1970: 1672901809),
         taskName: "Add Shadow Effect in Mockview App",
         taskDescription: "",
         taskCategory: .idea),
    
    Task(dateAdded: Date(timeIntervalSince1970: 1672901809),
         taskName: "Twitter/Instagram Post",
         taskDescription: "",
         taskCategory: .general),
    
    Task(dateAdded: Date(timeIntervalSince1970: 1672923409),
         taskName: "SEFA Geometry Effect (Issue)",
         taskDescription: "",
         taskCategory: .modifiers)
]

