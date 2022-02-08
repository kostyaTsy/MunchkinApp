//
//  AddPlayerView.swift
//  MunchkinApp
//
//  Created by Kostya Tsyvilko on 6.02.22.
//

import SwiftUI
import CoreData

struct AddPlayerView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
    
    @State var playerName: String = ""
    var body: some View {
        VStack (alignment: .leading) {
            Text("New player")
                .font(.title)
                .bold()
                .padding()
            TextField("Player name", text: $playerName)
                .textFieldStyle(.roundedBorder)
                .disableAutocorrection(true)
            
            Button {
                if playerName != "" {
                    addItem()
                    dismiss()
                }
            } label: {
                Text("Add player")
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.gray)
                    .cornerRadius(30)
                    .padding()
            }

            Spacer()
        }
        .padding()
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.name = playerName
            newItem.sex = "man"
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
}

/*struct AddPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlayerView()
            .preferredColorScheme(.light)
.previewInterfaceOrientation(.portrait)
    }
}*/
