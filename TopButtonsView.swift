//
//  TopButtonsView.swift
//  MunchkinApp
//
//  Created by Kostya Tsyvilko on 6.02.22.
//

import SwiftUI

struct TopButtonsView: View {
    @State var hel = 0
    var body: some View {
        VStack {
            Button {
                self.hel += 1
            } label: {
                VStack {
                    Image(systemName: "star")
                    Text("Add")
                }
            }

        }
    }

}

struct TopButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        TopButtonsView()
    }
}
