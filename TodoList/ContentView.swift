import SwiftUI
import RealmSwift

@available(iOS 16.0, *)
struct ContentView: View {
    @Environment(\.scenePhase) var appState
    
    @ObservedResults(Task.self) var tasks: Results<Task>
    
    let emptyTask = Task()
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                TodoListView()
                    .clipped()
                    .animation(.easeOut)
                    .transition(.slide)
            
                Spacer()
                ZStack{
                    HStack{
                        Spacer()
                        NavigationLink{
                            EmptyView(tasks: $tasks, task: emptyTask)
                        }label:{
                            Image("addNew")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60)
    //                        Text("New note")
    //                            .foregroundColor(Color(hex: "e6c244"))
                        }
                    }
                    .padding()
                }
                Spacer()
            
            }.padding()
                .navigationTitle("Tasks")
        }
     }
}
