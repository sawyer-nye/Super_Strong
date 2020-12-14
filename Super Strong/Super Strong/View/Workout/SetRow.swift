//
//  SetRow.swift
//  Super Strong
//
//  Created by Sawyer Nye on 11/16/20.
//

import SwiftUI

struct SetRow: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var setCollection: SetCollectionMO
    
    private func toggleComplete() {
        setCollection.isComplete.toggle()
    }
    
    private var weightText: String {
        let liftName = setCollection.exercise.lift.liftName
        var setWeight: Float = 0
        
        if let program = setCollection.exercise.workout.program {
            switch liftName {
            case "Back Squat":
                setWeight = (Float(program.squat1RM) * setCollection.percentage1RM).rounded(to: 5)
            case "Bench Press":
                setWeight = (Float(program.bench1RM) * setCollection.percentage1RM).rounded(to: 5)
            case "Deadlift", "Conventional Deadlift", "Sumo Deadlift":
                setWeight = (Float(program.deadlift1RM) * setCollection.percentage1RM).rounded(to: 5)
            case "Overhead Press":
                setWeight = (Float(program.overheadPress1RM) * setCollection.percentage1RM).rounded(to: 5)
            default:
                return ""
            }
            return "@ \(setWeight) lbs"
        } else {
            return ""
        }
    }
    
    private var setsText: String {
        if setCollection.hasPlusSet {
            return "\(setCollection.sets) x \(setCollection.reps)+ reps \(weightText) [rep out last set]"
        } else {
            return "\(setCollection.sets) x \(setCollection.reps) reps \(weightText)"
        }
        
    }
    
    var body: some View {
        Button(action: { self.toggleComplete() }) {
            HStack {
                Text(setsText)
                if setCollection.isComplete {
                    Spacer()
                    Image(systemName: "checkmark.seal.fill")
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
