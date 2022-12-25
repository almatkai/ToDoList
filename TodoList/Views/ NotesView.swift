//
//  NotesView.swift
//  TodoList
//
//  Created by Mohammad Azam on 6/18/22.
//

import SwiftUI
import RealmSwift

extension Color {
    static func random() -> Color {
        return Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    }
}

struct NotesView: View {
    
    @ObservedRealmObject var task: Task
    @State private var noteText: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter note", text: $noteText, axis: .vertical)
                .textFieldStyle(.roundedBorder)
            Button(action: {
                let note = Note()
                note.text = noteText
                
                if(!noteText.isEmpty){
                    $task.notes.append(note)
                }
                // clear the textbox
                noteText = ""
            }, label: {
                Text("Save note")
            }).buttonStyle(.borderedProminent)
                .disabled(noteText.isEmpty)
            
            List {
                ForEach(task.notes.indices, id: \.self) { index in
                    let note = task.notes[index]
                    HStack {
                        Text("\(index + 1)")
                            .frame(width: 25, height: 25)
                            .background(Color.random())
                            .foregroundColor(.white
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 6.0, style: .continuous))
                        Text(note.text)
                    }
                }
                .onDelete(perform: $task.notes.remove)
                .listStyle(.plain)
            }
            .navigationBarTitle(task.title)
        }.padding()
    }

}
//
//struct NotesView_Previews: PreviewProvider {
//    static var previews: some View {
//        NotesView(task: Task())
//    }
//}
