//
//  ExerciseSets.swift
//  Super Strong
//
//  Created by Sawyer Nye on 11/12/20.
//

import SwiftUI

struct ExerciseSets: View {
    @ObservedObject var exercise: ExerciseMO
    
    var sortedSetCollections: [SetCollectionMO] {
        exercise.setCollections.sorted { $0.setCollectionNumber < $1.setCollectionNumber }
    }
    
    var setsSection: some View {
        Section(header: Text("Sets")) {
            ForEach(sortedSetCollections) { setCollection in
                SetRow(setCollection: setCollection)
            }
        }
    }
    
    var notesSection: some View {
        Section(header: Text("Notes")) {
            if let _ = exercise.workout.program {
                TextEditor(text: $exercise.note)
            } else {
                Text("Disabled").foregroundColor(.secondary)
            }
        }
    }
    
    var body: some View {
        List {
            setsSection
            notesSection
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("\(exercise.lift.liftName)", displayMode: .inline)
    }
}
