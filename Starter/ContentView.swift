//
//  ContentView.swift
//  Starter
//
//  Created by Xumak on 23/09/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: Item.getAllItems()) 
    
    private var items: FetchedResults<Item>
    @State private var newToDoItem = ""
    private var isValidText: Bool {
        return newToDoItem != ""
    }

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("What's Next?")) {
                    HStack {
                        let color = isValidText ? Color.init(.clear) : Color.init(.lightGray)
                        TextField("New Item", text: self.$newToDoItem)
                            .background(color)
                        Button(action: {
                            addItem()
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                                .imageScale(.large)
                        }
                    }
                }.font(.headline)
                Section(header: Text("To Dos")) {
                    ForEach(self.items) { item in
                        ItemView(title: item.title ?? "Untitled", createdAt: item.createdAt ?? Date())
                    }.onDelete(perform: { indexSet in
                        deleteItems(offsets: indexSet)
                    })
                }
            }
            .navigationTitle("To Do List")
            .navigationBarItems(trailing: EditButton())
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.title = self.newToDoItem
            newItem.createdAt = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        self.newToDoItem = ""
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
