//
//  AutocompleteTextField.swift
//
//  Created by Janene Pappas on 9/1/23.
//

import Foundation
import SwiftUI
import Combine

struct AutocompleteTextField: View {
    
    @State private var showList: Bool = false
    @State private var choicePicked = false
    @State private var filteredChoices = [String]()
    @State private var choicesLowercased = [String]()
    
    @State private var selectedChoice = ""
    
    @Binding var choices: [String]
    
    var body: some View {
        VStack {
            HStack {
                Text("choice: ")
                TextField("choice", text: $selectedChoice)
                    .onReceive(Just(selectedChoice)) { selectedchoice in
                        if (selectedChoice.count > 1 && !choicePicked) {
                            showList = true
                        }
                        if (selectedChoice.count < 2) {
                            choicePicked = false
                        }
                        // update the filtered list of choices
                        filteredChoices = selectedChoice.count < 1 ? choicesLowercased : choicesLowercased.filter({$0.contains(selectedChoice.lowercased())})
                    }
                    .textFieldStyle(.roundedBorder)
                
                    .overlay (alignment: .top) {
                        VStack {
                            if showList {
                                Spacer(minLength: 20)
                                ChoicesDropDown(filteredChoices: $filteredChoices, selectedChoice: $selectedChoice, showList: $showList, choicePicked: $choicePicked, action: { choice in
                                })
                                Spacer(minLength: 20)
                            }
                        }
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                        .background(RoundedRectangle(cornerRadius: 10).fill(backgroundColor))
                    }
            }
        }
        .onAppear() {
            choicesLowercased = choices.map { $0.lowercased() }.sorted()
            filteredChoices = choicesLowercased
        }
    }
    
    //TODO: generalize this so it is available everywhere
    @Environment(\.colorScheme) var colorScheme
    
    var textColor: Color {
        if colorScheme == .dark {
            return Color.white
        } else {
            return Color.black
        }
    }
    var backgroundColor: Color {
        if colorScheme == .dark {
            return Color.black
        } else {
            return Color.white
        }
    }
}

struct ChoicesDropDown: View {
    

    @Binding var filteredChoices: [String]
    @Binding var selectedChoice: String
    @Binding var showList: Bool
    @Binding var choicePicked: Bool

    let action : (String?) -> Void

    var body: some View {
        
        VStack(alignment: .leading, spacing: 4){
            
            ForEach(filteredChoices, id: \.self) { choice in
                
                Button(action: {
                    selectedChoice = choice.capitalized
                    choicePicked = true
                    showList = false
                }) {
                    Text(choice.capitalized)
                }
                .foregroundColor(textColor)
            }
        }
        .background(backgroundColor)
    }
    
    @Environment(\.colorScheme) var colorScheme

    var textColor: Color {
        if colorScheme == .dark {
            return Color.white
        } else {
            return Color.black
        }
    }
    var backgroundColor: Color {
        if colorScheme == .dark {
            return Color.black
        } else {
            return Color.white
        }
    }
}
