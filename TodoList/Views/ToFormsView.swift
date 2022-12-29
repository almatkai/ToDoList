//
//  ToFormsView.swift
//  TodoList
//
//  Created by Almat Kairatov on 25.12.2022.
//


import SwiftUI
import RealmSwift

@available(iOS 16.0, *)
struct ToFormsView: View {
    //Date Picker
    static let calendar = Calendar(identifier: .gregorian)
    static let locale = Locale(identifier: "en_GB")
    ///
    
    @State private var taskName: String = ""
    @State private var priority: Priority = .medium
    
    private func priorityBackground(_ priority: String) -> Color {
        switch priority {
            case "Low":
                return .gray
            case "Medium":
                return .orange
            case "High":
                return .red
        default:
            return .orange
        }
    }
    
    @ObservedResults(Task.self) var tasks: Results<Task>

    @State private var date = Date.now
    
    var body: some View {
        TextField("Enter task", text: $taskName, axis: .vertical)
            .textFieldStyle(PlainTextFieldStyle())
            .padding(.top,10)
        HStack{
            DatePicker("", selection: $date)
                .environment(\.locale, Self.locale)
                .environment(\.calendar, Self.calendar)
        
            Picker("Priority", selection: $priority) {
                ForEach(Priority.allCases, id: \.self) { priority in
                    Text(priority.rawValue)
                        .font(.system(size:14))
                        .foregroundColor(priorityBackground(priority.rawValue))
                }
                .fontWeight(.bold)
                
            }.pickerStyle(.wheel)
                .frame(width: 100, height: 120)
                .foregroundColor(.green)
                .font(.headline)
        }
        Button {
            // action
            let task = Task()
            task.title = taskName
            task.priority = priority
            task.date = date

            if(!taskName.isEmpty){
                $tasks.append(task)
            }
            taskName = ""
            date = Date.now
            
        } label: {
            Text("Save")
                .frame(maxWidth: .infinity)
            }.buttonStyle(.borderedProminent)
            .disabled(taskName.isEmpty)
    }
}
