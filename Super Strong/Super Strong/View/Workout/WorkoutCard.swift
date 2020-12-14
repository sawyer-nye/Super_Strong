//
//  WorkoutCard.swift
//  Super Strong
//
//  Created by Sawyer Nye on 11/11/20.
//

import SwiftUI

struct WorkoutCard: View {
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var workout: WorkoutMO
    @ObservedObject var user: UserMO
    var width: CGFloat
    
    private var workoutType: String? { workout.workoutType }
    
    private var weekDayText: String {
        if workout.week != 0 && workout.day != 0 {
            return "Week \(workout.week) | Day \(workout.day)"
        }
        return ""
    }
    
    private var cardContents: some View {
        HStack {
            VStack(alignment: .leading) {
                if let program = workout.program {
                    Text("\(program.programName)")
                        .font(.title)
                        .foregroundColor(.primary)
                        .bold()
                } else {
                    Text(workout.name ?? "Quick Workout")
                        .font(.title2)
                        .foregroundColor(.primary)
                        .bold()
                }
                if !weekDayText.isEmpty {
                    Text(weekDayText)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                } else {
                    Text(workoutType ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
    }
    
    var body: some View {
        NavigationLink(destination: WorkoutView(workout: workout, user: user)) {
            VStack {
                cardContents
            }
            .background(
                colorScheme == .dark ? Color(.secondarySystemBackground) : Color(.systemBackground)
            )
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding()
        }
    }
}
