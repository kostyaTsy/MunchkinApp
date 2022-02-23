//
//  PlayerRow.swift
//  MunchkinApp
//
//  Created by Kostya Tsyvilko on 6.02.22.
//

import SwiftUI

struct WinnerInfo {
    var isWinner: Bool = false
    var winnerName: String = ""
}

struct PlayerRow: View {
    @Environment(\.managedObjectContext) var viewContext
    @StateObject var item: Item
    
    @Binding var winnerInfo: WinnerInfo
    var body: some View {
        HStack {
            VStack {
                Image(item.sex == "man" ? "man" : "woman")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        item.sex = item.sex == "man" ? "woman" : "man"
                    }
            }
            VStack(alignment: .leading) {
                Text(item.name ?? "Player")
                    .font(.title2)
                    .bold()
                Text("level: \(item.level)")
                    .font(.body)
            }
            
            Spacer()

            Stepper {
                Text("")
            } onIncrement: {
                incrementLevel()
            } onDecrement: {
                decrementLevel()
            }
            .padding(.trailing, 40)
            .scaleEffect(1.3)
        }
    }
    
    // Incrementing level of current player
    // Saving(resaving) changed player
    private func incrementLevel() {
        if item.level < 10 {
            item.level += 1
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        if item.level == 10 {
            winnerInfo.isWinner = true
            winnerInfo.winnerName = item.name ?? "No player's name"
        }
    }
    
    // Decrementing level of current player
    // Saving(resaving) changed player
    private func decrementLevel() {
        if item.level > 1 {
            item.level -= 1
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
