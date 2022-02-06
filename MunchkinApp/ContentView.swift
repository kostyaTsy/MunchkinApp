//
//  ContentView.swift
//  MunchkinApp
//
//  Created by Kostya Tsyvilko on 6.02.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    @State private var playerName: String = ""
    @State private var isShow: Bool = false
    var body: some View {
        //NavigationView {
        ZStack {
            List {
                // TODO: new view to add players
                Section {
                    HStack {
                        TextField("Label", text: $playerName)
                        Button(action: addItem) {
                            Text("Add player")
                        }
                        /*Button {
                            isShow.toggle()
                        } label: {
                            Text("Add player")
                        }*/
                    }
                }
                ForEach(items) { item in
                    PlayerRow(item: item)
                }
                .onDelete(perform: deleteItems)
            }
        }.sheet(isPresented: $isShow){
            AddPlayerView().environment(\.managedObjectContext, viewContext)
        }


            /*.toolbar {
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }*/
        //}
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.name = playerName
            newItem.sex = "men"
            newItem.level = 1
            
            playerName = ""
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
