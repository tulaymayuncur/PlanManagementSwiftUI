//  Home.swift
//  PlanManagement
//
//  Created by Tülay MAYUNCUR on 21.04.2023.
//


import SwiftUI

struct Home: View{
    
    /// -View Properties
    @State private var currentDay: Date = .init()
    @State private var tasks: [Task] = sampleTasks
    @State private var addNewTask: Bool = false
    

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            TimelineView()
                .padding(15)
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            HeaderView()
        }
        .fullScreenCover(isPresented: $addNewTask ){
            AddTaskView { task in
                /// - Simply Add it to tasks
                
                tasks.append(task)
                
                
            }
            
        }
    }
    
    /// - Timeline View
    @ViewBuilder
    func TimelineView() -> some View {
        ScrollViewReader { proxy in
            let hours = Calendar.current.hours
            let midHour = hours[hours.count / 2]
            VStack {
                ForEach(hours, id: \.self){hour in
                    TimelineViewRow(hour)
                        .id(hour)
                }
            }
            .onAppear {
                proxy.scrollTo(midHour)
            }
        }
    }
    
    /// - Timeline View Row
    @ViewBuilder
    func TimelineViewRow(_ date: Date) -> some View {
        HStack(alignment: .top) {
            Text(date.toString("h a"))
                .ubuntu(14, .regular)
                .frame(width: 45, alignment: .leading)
            
    /// - Filtering Tasks
            let calendar = Calendar.current
            let filteredTasks = tasks.filter{
                if let hour = calendar.dateComponents([.hour], from: date).hour,
                   
                   let taskHour = calendar.dateComponents([.hour], from: $0.dateAdded).hour,
                   
                  hour == taskHour && calendar.isDate($0.dateAdded, inSameDayAs: currentDay){
                  
                   return true
                  }
                  return false
              }
            

            if filteredTasks.isEmpty {
                Rectangle()
                    .stroke(.gray.opacity(0.5), style: StrokeStyle(lineWidth: 0.5, lineCap: .butt, lineJoin: .bevel,  dash: [5], dashPhase: 5))
                    .frame(height: 0.5)
                    .offset(y: 10)
                } else {
                    
                    // - Task View
                    
                    VStack(spacing: 10){
                        ForEach(filteredTasks){task in
                            TaskRow(task)
                    }
                }
            }
        }
        .hAlign(.leading)
        .padding(.vertical, 15)
    }
    
    // - Task Row
    @ViewBuilder
    func TaskRow(_ task: Task)-> some View{
        VStack(alignment: .leading, spacing: 8) {
           
            Text(task.taskName.uppercased())
                    .ubuntu(16, .regular)
                    .foregroundColor(task.taskCategory.color)
            if task.taskDescription != ""{
                Text(task.taskDescription)
                    .ubuntu(14, .light)
                    .foregroundColor(task.taskCategory.color.opacity(0.8))
              }
        }
        .hAlign(.leading)
        .padding(12)
        .background {
            ZStack(alignment: .leading){
                Rectangle()
                    .fill(task.taskCategory.color)
                    .frame(width: 4)
                Rectangle()
                    .fill(task.taskCategory.color.opacity(0.25))
                
            }
        }
    }
   
    /// - Header View
    @ViewBuilder
    func HeaderView() -> some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Today")
                        .ubuntu(30, .light)
                    
                    Text("Welcome !")
                        .ubuntu(14, .light)
                }
                .hAlign(.leading)
                
                Button{
                    addNewTask.toggle()
                    
                } label:
                
            {
   
                    HStack(spacing: 10){
                        Image(systemName: "plus")
                        Text("Add Task")
                            .ubuntu(15, .regular)
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal,15)
                    .background {
                        Capsule()
                            .fill(Color.blue)
                        
                    }
                    .background(Color.white)
                }
                .foregroundColor(.white)
            }
    /// - Today Date in String
            
            Text(Date().toString("MMM YYYY"))
                .ubuntu(16, .medium)
                .hAlign(.leading)
                .padding(.top,15)
            
    /// - Current Week Row
            WeekRow()
            
        }
        .padding(15)
        .background{
            VStack(spacing: 0){
                Color.white
    /// - Gradient Opacity Backgrond
                Rectangle()
                    .fill(.linearGradient(colors: [
                        .white,
                        .clear
                    ], startPoint: .top, endPoint: .bottom))
                    .frame(height: 20)
            }
            .ignoresSafeArea()
        }
    }
    
/// - Week Row
    @ViewBuilder
    func WeekRow()-> some View{
        HStack(spacing: 0){
            ForEach(Calendar.current.currentWeek){ weekDay in
                let status = Calendar.current.isDate(weekDay.date, inSameDayAs: currentDay)
                VStack(spacing:6){
                    Text(weekDay.string.prefix(3))
                        .ubuntu(12, .medium)
                    Text(weekDay.date.toString("dd"))
                        .ubuntu(16, status ? .medium :  .regular)
                        
                }
                .foregroundColor(status ? Color.blue : Color.gray)
                .hAlign(.center)
                .containerShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)){
                        currentDay = weekDay.date
                    }
                }
            }
        }
        .padding(.vertical,10)
        .padding(.horizontal,-15)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: View Extensions

extension View {
    func hAlign(_ alignment: Alignment) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vAlign(_ alignment: Alignment) -> some View {
        self.frame(maxHeight: .infinity, alignment: alignment)
    }
}

// MARK: Date Extension

extension Date {
    func toString(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

// MARK : Calander Extension

extension Calendar {
    
    /// - Returns Current Week in Array Format
    
    var hours: [Date]{
        let startOfDay = self.startOfDay(for: Date())
        var hours: [Date] = []
        for index in 0..<24{
            if let date = self.date(byAdding: .hour, value: index, to: startOfDay){
                hours.append(date)
            }
            
        }
        return hours
    }
    
    var currentWeek: [WeekDay] {
        guard let firstWeekDay = self.dateInterval(of: .weekOfMonth, for: Date())?.start else { return [] }
        var week: [WeekDay] = []
        for index in 1..<7 {
            if let day = self.date(byAdding: .day, value: index, to: firstWeekDay) {
                let weekDaySymbol: String = day.toString("EEEE")
                
                let isToday = self.isDateInToday(day)
                week.append(.init(string: weekDaySymbol, date: day, isToday: isToday))
            }
        }
        
        return week
    }
    
    /// - Used to Store Data of Each Week Day
    struct WeekDay: Identifiable {
        var id: UUID = .init()
        var string: String
        var date: Date
        var isToday: Bool = false
    }
}
