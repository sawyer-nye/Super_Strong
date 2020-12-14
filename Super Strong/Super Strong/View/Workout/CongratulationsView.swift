//
//  CongratulationsView.swift
//  Super Strong
//
//  Created by Sawyer Nye on 12/13/20.
//

import SwiftUI

struct CongratulationsView: View {
    @ObservedObject var user: UserMO
    @Binding var revealSheet: Bool
    
    var body: some View {
        VStack {
            Text("Congratulations!")
                .font(.title)
                .foregroundColor(.primary)
            Text("You finished \(user.currentProgram?.programName ?? "")")
                .font(.headline)
                .foregroundColor(.secondary)
            HStack {
                Button("Dismiss") {
                    revealSheet = false
                }
            }
        }
        .onDisappear {
            user.currentProgram = nil
        }
    }
}
