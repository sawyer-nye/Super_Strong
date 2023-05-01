//
//  WorkoutView.swift
//  Super Strong
//
//  Created by Sawyer Nye on 11/11/20.
//

import SwiftUI

struct WorkoutView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var workout: WorkoutMO
    @ObservedObject var user: UserMO
    
    @State var revealCongratulations: Bool = false

    var noNotes: Bool {
        for workout in workout.exercises {
            if !workout.note.isEmpty {
                return false
            }
        }
        return true
    }
    
    var sortedExercises: [ExerciseMO] {
        Array(workout.exercises).sorted { $0.exerciseNumber < $1.exerciseNumber }
    }
    
    func finishWorkout() {
        if let program = workout.program {
            if workout.day == program.currentDay && workout.week == program.currentWeek {
                if program.currentDay == program.daysPer && program.currentWeek == program.weeksPer {
                    revealCongratulations = true    // Program is finished
                    //program.currentWeek = 1
                    //program.currentDay = 1
                } else if program.currentDay == program.daysPer {
                    program.currentWeek += 1
                    program.currentDay = 1
                } else {
                    program.currentDay += 1
                }
                
                workout.finishDate = Date()
                user.addToCompletedWorkouts(workout)
                
                do {
                    try viewContext.save()
                } catch {
                    print("error: \(error)")
                }
            }
        }
        if revealCongratulations == false {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    var body: some View {
        List {
            exerciseSection
            notesSection
            finishSection
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("Today's Workout", displayMode: .inline)
        .sheet(isPresented: $revealCongratulations) {
            CongratulationsView(user: user, revealSheet: $revealCongratulations)
        }
    }
    
    var exerciseSection: some View {
        Section(header: Text("Exercises")) {
            ForEach(sortedExercises) { exercise in
                ExerciseRow(exercise: exercise)
            }
        }
    }
    
    var notesSection: some View {
        Section(header: Text("Notes")) {
            if let _ = workout.program {
                ForEach(Array(workout.exercises)) { exercise in
                    if !exercise.note.isEmpty {
                        HStack {
                            Text("\(exercise.lift.liftName):")
                                .bold()
                            Text(exercise.note)
                        }
                    }
                }
                if noNotes {
                    Text("No notes")
                }
            } else {
                Text("Disabled")
                    .foregroundColor(.secondary)
            }
        }
    }
    
    var finishSection: some View {
        Section(header: Text("Finish")) {
            if let _ = workout.finishDate {
                Text("Workout Complete")
            } else {
                HStack {
                    Spacer()
                    Button(action: { finishWorkout() }) {
                        Text("Finish Workout")
                    }
                    Spacer()
                }
            }
        }
    }
}
