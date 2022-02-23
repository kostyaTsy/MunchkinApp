//
//  ContentView.swift
//  MunchkinApp
//
//  Created by Kostya Tsyvilko on 6.02.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // context that stored data about players
    @Environment(\.managedObjectContext) var viewContext
    
    // array for storing data in alphabet order
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var playerName: String = ""
    
    // State var for show views or alerts
    @State private var isShowAddPlayerView: Bool = false
    @State private var isAlertShow: Bool = false
    @State var winnerInfo: WinnerInfo
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    if items.count > 0 {
                        // Filling list with data about players
                        ForEach(items) { item in
                            PlayerRow(item: item, winnerInfo: $winnerInfo)
                                .alert("Winner is: \(winnerInfo.winnerName)", isPresented: $winnerInfo.isWinner) {
                                    Button("Ok", role: .cancel) {}
                                }    
                        }
                        .onDelete(perform: deleteItems)
                    }
                    else {
                        Text("No players")
                    }
                }
                // toolbar for adding new players
                // finding player with first move
                // new game, deleting all players from context
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
                        Button {
                            isAlertShow.toggle()
                        } label: {
                            VStack{
                                Image(systemName: "dice")
                                Text("First turn")
                            }
                        }.alert("First move for: \(findPlayerFirstTurn())", isPresented: $isAlertShow) {
                            Button("Ok", role: .cancel) { }
                        }
                        Button {
                            deleteAllItems()
                        } label: {
                            VStack{
                                Image(systemName: "rectangle.on.rectangle")
                                Text("New game")
                            }
                        }
                    }
                }
            }.sheet(isPresented: $isShowAddPlayerView){
                AddPlayerView()
                    .environment(\.managedObjectContext, viewContext)
            }
        }
    }
    
    // Deleting chosen player from context
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // Deleting all players
    private func deleteAllItems() {
        for item in items {
            viewContext.delete(item)
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
    }
    
    // Finding player with first turn
    private func findPlayerFirstTurn() -> String {
        if items.count > 0 {
            let randomPlayerInd = Int.random(in: 0..<items.count)
            return items[randomPlayerInd].name ?? "No player's name"
        }
        return "No players"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(winnerInfo: WinnerInfo(isWinner: false, winnerName: "")).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
