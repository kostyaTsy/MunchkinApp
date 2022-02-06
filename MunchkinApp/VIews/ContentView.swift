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
    @State private var isShowAddPlayerView: Bool = false
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    // TODO: new view to add players
                    /*Section {
                     HStack {
                     //TextField("Label", text: $playerName)
                     /*Button(action: addItem) {
                      Text("Add player")
                      }*/
                     Button {
                     print("alo")
                     findPlayerFirstTurn()
                     } label: {
                     Text("First turn")
                     }
                     Spacer()
                     Button {
                     isShowAddPlayerView.toggle()
                     } label: {
                     Text("Add player")
                     }
                     
                     }
                     }*/
                    ForEach(items) { item in
                        PlayerRow(item: item)
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button {
                            isShowAddPlayerView.toggle()
                        } label: {
                            VStack{
                                Image(systemName: "person.badge.plus")
                                Text("Add player")
                            }
                        }
                        //Spacer()
                        Button {
                            findPlayerFirstTurn()
                        } label: {
                            VStack{
                                Image(systemName: "dice")
                                Text("First turn")
                            }
                        }
                        //Spacer()
                        Button {
                            print("")
                        } label: {
                            VStack{
                                Image(systemName: "rectangle.on.rectangle")
                                Text("New game")
                            }
                        }
                    }
                }
            }.sheet(isPresented: $isShowAddPlayerView){
                AddPlayerView().environment(\.managedObjectContext, viewContext)
            }
            
            
            /*.toolbar {
             ToolbarItem {
             Button(action: addItem) {
             Label("Add Item", systemImage: "plus")
             }
             }
             }*/
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
    
    private func findPlayerFirstTurn() {
        print(items.count)
        for item in items {
            print(item)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
