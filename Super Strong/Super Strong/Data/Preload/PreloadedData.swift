//
//  PreloadedData.swift
//  Super Strong
//
//  Created by Sawyer Nye on 11/17/20.
//
//  PreloadedData is a store of all previously used statements to load into the db...
//  Nothing here is called within the app; if it exists here, it is already inside of Data/Super_Strong.sqlite*

import SwiftUI
import CoreData

/// These lifts have been preloaded already via the Data/*.sqlite* files. This file serves as a backup in case I need to reload the initial database stores
struct PreloadedLifts {
/*
    /* Squat */
    let lift_squat = LiftMO(context: viewContext)
    lift_squat.liftName = "Back Squat"
    lift_squat.primaryMuscleGroup = "Quadriceps"
    lift_squat.secondaryMuscleGroups = ["Hamstrings", "Lower Back", "Abdominals"]
    /* Bench */
    let lift_bench = LiftMO(context: viewContext)
    lift_bench.liftName = "Bench Press"
    lift_bench.primaryMuscleGroup = "Chest"
    lift_bench.secondaryMuscleGroups = ["Triceps", "Front Deltoids"]
    /* Conventional Deadlift */
    let lift_deadlift = LiftMO(context: viewContext)
    lift_deadlift.liftName = "Conventional Deadlift"
    lift_deadlift.primaryMuscleGroup = "Lower Back"
    lift_deadlift.secondaryMuscleGroups = ["Hamstrings", "Upper Back"]
    /* Sumo Deadlift */
    let lift_sumo_deadlift = LiftMO(context: viewContext)
    lift_sumo_deadlift.liftName = "Sumo Deadlift"
    lift_sumo_deadlift.primaryMuscleGroup = "Lower Back"
    lift_sumo_deadlift.secondaryMuscleGroups = ["Hamstrings", "Upper Back", "Quadriceps"]
    /* Front Squat */
    let lift_front_squat = LiftMO(context: viewContext)
    lift_front_squat.liftName = "Front Squat"
    lift_front_squat.primaryMuscleGroup = "Quadriceps"
    lift_front_squat.secondaryMuscleGroups = ["Abdominals", "Upper Back"]
    /* Overhead Press */
    let lift_ohp = LiftMO(context: viewContext)
    lift_ohp.liftName = "Overhead Press"
    lift_ohp.primaryMuscleGroup = "Front Deltoids"
    lift_ohp.secondaryMuscleGroups = ["Triceps", "Side Deltoids"]}
    /* Deadlift */
    let lift_deadlift = LiftMO(context: viewContext)
    lift_deadlift.liftName = "Deadlift"
    lift_deadlift.primaryMuscleGroup = "Lower Back"
    lift_deadlift.secondaryMuscleGroups = ["Upper Back", "Hamstrings"]
*/
}
