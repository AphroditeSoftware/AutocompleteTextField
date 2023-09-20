//
//  ContentView.swift
//  AutocompleteTextField
//
//  Created by Janene Pappas on 9/20/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var choices = ["Great Wall of China", "Great Dane", "Aggregate", "Great balls of fire", "Zebra"]
    
    var body: some View {
        VStack {
            AutocompleteTextField(choices: $choices)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .zIndex(1.0)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
