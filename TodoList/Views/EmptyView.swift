//
//  EmptyView.swift
//  TodoList
//
//  Created by Almat Kairatov on 27.12.2022.
//

import SwiftUI
import RealmSwift

struct EmptyView: View {
    @State private var noteText: String = ""
    
    //Date Picker
    static let calendar = Calendar(identifier: .gregorian)
    static let locale = Locale(identifier: "en_GB")
    ///
    
    @State private var taskName: String = ""
    @State private var priority: Priority = .medium
    
    @ObservedResults(Task.self) var tasks: Results<Task>

    @State private var date = Date.now
    
    private func priorityBackground(_ priority: String) -> Color {
        switch priority {
            case "Low":
                return .gray
            case "Medium":
                return Color(hex: "e6c244")
            case "High":
                return .red
        default:
            return .orange
        }
    }
    
    @ObservedRealmObject var task: Task
    
    @State private var isAdded = false
    
    var body: some View {
        VStack {
            HStack{
                TextField("Enter note", text: $task.title, axis: .vertical)
                    .textFieldStyle(.plain)
                    .font(.system(size: 20))
                    .padding()
                    .onChange(of: task.title){ text in
                        if(!isAdded){
                            $tasks.append(task)
                            isAdded = true
                        }
                    }
                Picker("Priority", selection: $task.priority) {
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
            Divider()
            HStack{
                TextField("Enter subtask", text: $noteText, axis: .vertical)
                    .textFieldStyle(.plain)
                    .padding(.left, 18)
                Button(action: {
                    let note = Note()
                    note.text = noteText
                    
                    if(!noteText.isEmpty){
                        $task.notes.append(note)
                    }
                    // clear the textbox
                    noteText = ""
                }, label: {
                    Text("Add")
                }).buttonStyle(.borderedProminent)
                    .disabled(noteText.isEmpty)
            }
//            ToFormsView()
            Spacer()
            
            List {
                ForEach(task.notes.indices, id: \.self) { index in
                    let note = task.notes[index]
                    HStack {
                        Text("\(index + 1)")
                            .frame(width: 25, height: 25)
                            .background(.orange)
                            .foregroundColor(.white
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 6.0, style: .continuous))
                        Text(note.text)
                    }
                }
                .onDelete(perform: $task.notes.remove)
                .listStyle(.plain)
            }.listStyle(.plain)
//            .toolbar {
//                ToolbarItem(placement: .principal) {
////                    TextField("Navigation Title", text: $task.title)
////                        .font(.system(size:24))
////                        .fontWeight(.bold)
//                    Text("")
//                }
//            }
        }.padding()
    }
}
