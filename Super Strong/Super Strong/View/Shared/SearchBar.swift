//
//  SearchBar.swift
//  Super Strong
//
//  Created by Sawyer Nye on 11/22/20.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @State private var shouldShowCancelButton: Bool = false
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("search", text: $searchText, onEditingChanged: { isEditing in
                    self.shouldShowCancelButton = true
                }, onCommit: {
                    
                }).foregroundColor(.primary)
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
            
            if shouldShowCancelButton {
                Button("Cancel") {
                    UIApplication.shared.endEditing(true)
                    self.searchText = ""
                    self.shouldShowCancelButton = false
                }
                .foregroundColor(Color(.systemBlue))
            }
        }
        .padding()
        .navigationBarHidden(shouldShowCancelButton)
    }
}
