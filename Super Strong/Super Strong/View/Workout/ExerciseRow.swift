//
//  ExerciseRow.swift
//  Super Strong
//
//  Created by Sawyer Nye on 11/11/20.
//

import SwiftUI

struct ExerciseRow: View {
    @ObservedObject var exercise: ExerciseMO
    
    var numSetCollections: Int { exercise.setCollections.count }
    
    var numSets: Int64 {
        var totalSets: Int64 = 0
        for setCollection in exercise.setCollections {
            totalSets += setCollection.sets
        }
        
        return totalSets
    }

    var body: some View {
        NavigationLink(destination: ExerciseSets(exercise: exercise)) {
            VStack(alignment: .leading) {
                Text(exercise.lift.liftName)
                    .font(.system(.headline))
                Text("\(numSets) sets")
                    .font(.system(.caption))
            }
            .padding(.init(top: 8, leading: 0, bottom: 8, trailing: 0))
        }
    }
}
