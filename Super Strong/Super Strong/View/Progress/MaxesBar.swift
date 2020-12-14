//
//  MaxesBar.swift
//  Super Strong
//
//  Created by Sawyer Nye on 12/9/20.
//

import SwiftUI

struct MaxesBar: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var user: UserMO
    
    var squatColumn: some View {
        VStack(alignment: .center) {
            Text("Squat")
                .font(.title2)
                .foregroundColor(.primary)
                .bold()
            Text("\(user.squat1RM) lbs")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    var benchColumn: some View {
        VStack(alignment: .center) {
            Text("Bench")
                .font(.title2)
                .foregroundColor(.primary)
                .bold()
            Text("\(user.bench1RM) lbs")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    var deadliftColumn: some View {
        VStack(alignment: .center) {
            Text("Deadlift")
                .font(.title2)
                .foregroundColor(.primary)
                .bold()
            Text("\(user.deadlift1RM) lbs")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    var ohpColumn: some View {
        VStack(alignment: .center) {
            Text("OHP")
                .font(.title2)
                .foregroundColor(.primary)
                .bold()
            Text("\(user.overheadPress1RM) lbs")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                squatColumn
                Spacer()
                benchColumn
                Spacer()
                deadliftColumn
                Spacer()
                ohpColumn
                Spacer()
            }
            .padding()
        }
        .background(
            colorScheme == .dark ? Color(.secondarySystemBackground) : Color(.systemBackground)
        )
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }
}
