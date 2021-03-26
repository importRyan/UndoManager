import SwiftUI

struct ContentView: View {
    @Binding var document: DocumentTestDocument
    @Environment(\.undoManager) var undo
    @StateObject var vm = VM()
    
    @State var autoEnables = false
    
    var body: some View {
        VStack(spacing: 25) {
            HStack {
                Button("<") { vm.performUndo(undo: undo) }
                    .disabled(!(undo?.canUndo ?? true))
                
                Button("Up") { vm.increment(undo: undo) }
                Button("Down") { vm.decrement(undo: undo) }
                
                Button(">") { vm.performRedo(undo: undo) }
                    .disabled(!(undo?.canRedo ?? true))
            }
            
            Text(String(vm.count))
                .font(.title)
            
            Text("MenuItemTitle \(vm.title)")
            
        }
        .controlSize(.large)
        .font(.title3)
        .frame(width: 400, height:  300)
        .onAppear { DispatchQueue.main.async { autoEnables = NSApp.menu?.autoenablesItems ?? false } }
    }
}

class VM: ObservableObject {
    
    @Published var count = 0
    @Published var title = ""
    
    func increment(undo: UndoManager?) {
        count += 1
        
        undo?.registerUndo(withTarget: self, handler: { (targetSelf) in
            targetSelf.decrement(undo: undo)
        })
        undo?.setActionName("Increment")
        
        title = undo?.undoMenuItemTitle ?? "Nil"
    }
    
    func decrement(undo: UndoManager?) {
        count -= 1
        
        undo?.registerUndo(withTarget: self, handler: { (targetSelf) in
            targetSelf.increment(undo: undo)
        })
        undo?.setActionName("Increment")
        
        title = undo?.undoMenuItemTitle ?? "Nil"
    }
    
    func performUndo(undo: UndoManager?) {
        undo?.undo()
    }
    
    func performRedo(undo: UndoManager?) {
        undo?.redo()
    }
}
