//
//  CreateWorkoutView.swift
//  Super Strong
//
//  Created by Sawyer Nye on 12/11/20.
//

import SwiftUI

struct CreateWorkoutView: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var creationManager: ProgramCreationManager
    
    @ObservedObject var workout: WorkoutMO
    
    @State private var workoutTypeSelection = 1
    @State var revealAddExerciseSheet = false
    
    var exercises: [ExerciseMO] {
        workout.exercises.sorted { $0.exerciseNumber < $1.exerciseNumber }
    }
    
    var body: some View {
        Form {
            HStack {
                Spacer()
                Text("Day \(workout.day)")
                    .font(.title)
                Spacer()
            }
            Section(header: Text("Workout Type")) {
                Picker(selection: $workoutTypeSelection, label: Text("")) {
                    Text("Upper Body").tag(1)
                    Text("Lower Body").tag(2)
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 60)
            }
            Section(header: Text("Exercises")) {
                ForEach(exercises, id: \.self) { exercise in
                    HStack(alignment: .top) {
                        Image(systemName: "\(exercise.exerciseNumber).square.fill")
                            .font(.title2)
                            .padding(4)
                        VStack(alignment: .leading) {
                            HStack {
                                Text("\(exercise.lift.liftName)")
                                    .font(.title2)
                                    .foregroundColor(.primary)
                                Spacer()
                                ExerciseDeleteButton(exercise: exercise, workout: workout)
                            }
                            SetCollectionsView(exercise: exercise)
                        }
                    }
                }
                .id(UUID())
                HStack {
                    Spacer()
                    Button("Add an Exercise") { revealAddExerciseSheet = true }
                    Spacer()
                }
            }
        }
        .sheet(isPresented: $revealAddExerciseSheet) {
            AddExerciseView(workout: workout, revealSheet: $revealAddExerciseSheet)
                .environment(\.managedObjectContext, self.viewContext)
                .environmentObject(creationManager)
        }
    }
}
