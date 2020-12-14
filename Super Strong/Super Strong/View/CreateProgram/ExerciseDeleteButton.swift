//
//  ExerciseDeleteButton.swift
//  Super Strong
//
//  Created by Sawyer Nye on 12/13/20.
//

import SwiftUI

struct ExerciseDeleteButton: View {
    @EnvironmentObject var creationManager: ProgramCreationManager
    
    @ObservedObject var exercise: ExerciseMO
    @ObservedObject var workout: WorkoutMO
    
    var body: some View {
        Button(action: { creationManager.deleteExercise(exercise, for: workout) }) {
            Image(systemName: "trash.fill")
                .foregroundColor(Color(.systemRed))
        }
        .buttonStyle(PlainButtonStyle())
    }
}
