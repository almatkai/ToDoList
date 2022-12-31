//
//  TaskCellView.swift
//  TodoList
//
//  Created by Mohammad Azam on 6/18/22.
//

import SwiftUI

@available(iOS 16.0, *)
struct TaskCellView: View {
    
    let task: Task
    @Environment(\.realm) var realm
    @State var offsetY : CGFloat = 0
        
    private func priorityBackground(_ priority: Priority) -> Color {
        switch priority {
            case .low:
                return .gray
            case .medium:
                return Color(hex: "f7cf4c")
            case .high:
                return .red
        }
    }
    
    @State var mainTitle = "Main Menu"

    var body: some View {
//        @State var taskPos:
        NavigationLink {
            NotesView(task: task)
        } label: {
            VStack{
                HStack {
                    Image(systemName: task.isCompleted ? "checkmark.square": "square")
                        .foregroundColor(task.isCompleted ? .green : .gray)
                        .onTapGesture {
                            let taskToUpdate = realm.object(ofType: Task.self, forPrimaryKey: task._id)
                            try? realm.write {
                                taskToUpdate?.isCompleted.toggle()
                            }
                            
                        }
                    Text(task.title)
                        .lineLimit(2)
                    Spacer()
                    Text(task.priority.rawValue)
                        .padding(6)
                        .frame(width: 75)
                        .background(priorityBackground(task.priority))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                }
                HStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Text(task.date, style: .time)
                            .font(.system(size:12))
                        Text(task.date, style: .date)
                            .font(.system(size:12))
                    }
                }
            }
        }
    }
}

