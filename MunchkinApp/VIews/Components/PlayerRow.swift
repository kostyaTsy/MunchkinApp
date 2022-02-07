//
//  PlayerRow.swift
//  MunchkinApp
//
//  Created by Kostya Tsyvilko on 6.02.22.
//

import SwiftUI

struct PlayerRow: View {
    @Environment(\.managedObjectContext) var viewContext
    @StateObject var item: Item
    
    var body: some View {
        HStack {
            // TODO: add new icons
            VStack {
                Image(systemName: item.sex == "man" ? "person" : "person.fill")
                    .onTapGesture {
                        item.sex = item.sex == "man" ? "woman" : "man"
                    }
                    .foregroundColor(.orange)
                Text(item.sex ?? "No sex")
            }
            VStack(alignment: .leading) {
                Text(item.name ?? "Player")
                    .font(.title2)
                    .bold()
                Text("level: \(item.level)")
                    .font(.body)
            }
            Spacer()
            
            
            // TODO: Fix stepper with values
            Stepper {
                Text("")
            } onIncrement: {
                if item.level < 10 {
                    item.level += 1
                }
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
                
            } onDecrement: {
                if item.level > 1 {
                    item.level -= 1
                }
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
    }
}
