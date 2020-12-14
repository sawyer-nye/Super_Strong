//
//  ProgramCreationManager.swift
//  Super Strong
//
//  Created by Sawyer Nye on 12/11/20.
//

import Foundation
import CoreData

class ProgramCreationManager: ObservableObject {
    private let viewContext = PersistenceController.shared.container.viewContext
    
    @Published var program: ProgramMO?
    
    let mainLifts = ["Back Squat", "Bench Press", "Deadlift", "Overhead Press"]
    
    func initializeProgram(user: UserMO, _ programName: String, weeksPer: Int64, daysPer: Int64) {
        program = ProgramMO(context: viewContext)
        program!.programName = programName
        program!.weeksPer = weeksPer
        program!.daysPer = daysPer
        program!.currentWeek = 1
        program!.currentDay = 1
        program!.squat1RM = user.squat1RM
        program!.bench1RM = user.bench1RM
        program!.deadlift1RM = user.deadlift1RM
        program!.overheadPress1RM = user.overheadPress1RM
        
        for week in 1...weeksPer {
            for day in 1...daysPer {
                initializeWorkout(week: week, day: day)
            }
        }
    }
    
    func initializeWorkout(week: Int64, day: Int64) {
        let newWorkout = WorkoutMO(context: viewContext)
        newWorkout.week = Int64(week)
        newWorkout.day = Int64(day)
        
        program!.addToWorkouts(newWorkout)
        newWorkout.program = program!
    }
    
    func insertNewExercise(for workout: WorkoutMO, with lift: LiftMO) {
        let newExercise = ExerciseMO(context: viewContext)
        let maxExerciseNumber = workout.exercises.max {
            $0.exerciseNumber < $1.exerciseNumber
        }?.exerciseNumber ?? 0
        
        newExercise.exerciseNumber = maxExerciseNumber + 1
        newExercise.lift = lift
        
        let firstSetCollection = SetCollectionMO(context: viewContext)
        firstSetCollection.setCollectionNumber = 1
        firstSetCollection.sets = 1
        firstSetCollection.reps = 1
        if mainLifts.contains(newExercise.lift.liftName) {
            firstSetCollection.percentage1RM = 0.50
        }
        
        newExercise.addToSetCollections(firstSetCollection)
        firstSetCollection.exercise = newExercise
        
        workout.addToExercises(newExercise)
        newExercise.workout = workout
    }
    
    func insertNewLift(liftName: String,
                       primaryMuscleGroup: String,
                       secondaryMuscleGroups: [String]?)
    {
        let newLift = LiftMO(context: viewContext)
        newLift.liftName = liftName
        newLift.primaryMuscleGroup = primaryMuscleGroup
        newLift.secondaryMuscleGroups = secondaryMuscleGroups
    }
    
    func insertNewSetCollection(for exercise: ExerciseMO) {
        let newSetCollection = SetCollectionMO(context: viewContext)
        newSetCollection.sets = 1
        newSetCollection.reps = 1
        
        if mainLifts.contains(exercise.lift.liftName) {
            newSetCollection.percentage1RM = 0.50
        }
        
        let maxSetCollectionNumber = exercise.setCollections.max {
            $0.setCollectionNumber < $1.setCollectionNumber
        }?.setCollectionNumber ?? 1
        
        newSetCollection.setCollectionNumber = maxSetCollectionNumber + 1
        exercise.addToSetCollections(newSetCollection)
        newSetCollection.exercise = exercise
    }
    
    func deleteExercise(_ exercise: ExerciseMO, for workout: WorkoutMO) {
        if !workout.exercises.isEmpty {
            let sortedExercises = workout.exercises.sorted { $0.exerciseNumber < $1.exerciseNumber }
            let exerciseIndex = sortedExercises.firstIndex(of: exercise)!
            
            for j in exerciseIndex ..< sortedExercises.count {
                sortedExercises[j].exerciseNumber -= 1
            }
            
            workout.removeFromExercises(exercise)
            
            viewContext.delete(exercise)
        }
    }
    
    func deleteSetCollection(setCollection: SetCollectionMO, for exercise: ExerciseMO) {
        let sortedSetCollections = exercise.setCollections.sorted { $0.setCollectionNumber < $1.setCollectionNumber }
        let collectionIndex = sortedSetCollections.firstIndex(of: setCollection)!
        
        for i in collectionIndex ..< sortedSetCollections.count {
            sortedSetCollections[i].setCollectionNumber -= 1
        }
        
        exercise.removeFromSetCollections(setCollection)
        
        viewContext.delete(setCollection)
    }
    
    func duplicateWeek1Workouts() {
        // deep copying with core data is quite difficult
        // manually handling the references is a bit simpler here, and runs quite quickly
        let week1Workouts = program!.workouts.filter { $0.week == 1 }.sorted { $0.day < $1.day }
        let otherWorkouts = program!.workouts.filter { $0.week != 1 }
        
        let week1WorkoutsNotEmpty = week1Workouts.allSatisfy { !$0.exercises.isEmpty }
        let otherWorkoutsEmpty = otherWorkouts.allSatisfy { $0.exercises.isEmpty }
        
        let canDuplicate = week1WorkoutsNotEmpty && otherWorkoutsEmpty
        
        if canDuplicate {
            // O(n^4)? Small n though...
            for week in 2...program!.weeksPer {
                for day in 1...program!.daysPer {
                    let oldWorkout = program!.workouts.filter { $0.week == week && $0.day == day }.first!
                    let existingWorkout = week1Workouts[Int(day-1)]
                    oldWorkout.workoutType = existingWorkout.workoutType
                    
                    for exercise in existingWorkout.exercises {
                        let newExercise = ExerciseMO(context: viewContext)
                        newExercise.exerciseNumber = exercise.exerciseNumber
                        newExercise.lift = exercise.lift
                        
                        for setCollection in exercise.setCollections {
                            let newSetCollection = SetCollectionMO(context: viewContext)
                            newSetCollection.setCollectionNumber = setCollection.setCollectionNumber
                            newSetCollection.exercise = exercise
                            newSetCollection.hasPlusSet = setCollection.hasPlusSet
                            newSetCollection.percentage1RM = setCollection.percentage1RM
                            newSetCollection.reps = setCollection.reps
                            newSetCollection.sets = setCollection.sets
                            
                            newExercise.addToSetCollections(newSetCollection)
                            newSetCollection.exercise = newExercise
                        }
                        oldWorkout.addToExercises(newExercise)
                        newExercise.workout = oldWorkout
                    }
                }
            }
        } else {
            print("Failed to duplicate")
        }
    }
        
    func commitProgram() {
        do {
            try viewContext.save()
        } catch {
            print("Failed to save program. Error: \(error)")
        }
        
        program = nil
    }
}
