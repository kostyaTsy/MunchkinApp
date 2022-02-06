//
//  PlayerRow.swift
//  MunchkinApp
//
//  Created by Kostya Tsyvilko on 6.02.22.
//

import SwiftUI

struct PlayerRow: View {
    @StateObject var item: Item
    
    var body: some View {
        HStack {
            // TODO: add new icons
            Image(systemName: item.sex == "man" ? "person" : "person.fill")
                .onTapGesture {
                    item.sex = item.sex == "man" ? "woman" : "man"
                }
                .foregroundColor(.orange)
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
                item.level += 1
            } onDecrement: {
                item.level -= 1
            }
        }
    }
}
