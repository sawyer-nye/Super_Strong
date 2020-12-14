//
//  SetCollectionsView.swift
//  Super Strong
//
//  Created by Sawyer Nye on 12/12/20.
//

import SwiftUI

struct SetCollectionsView: View {
    @EnvironmentObject var creationManager: ProgramCreationManager
    @ObservedObject var exercise: ExerciseMO
        
    var setCollections: [SetCollectionMO] {
        exercise.setCollections.sorted { $0.setCollectionNumber < $1.setCollectionNumber }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Set Collections:")
                .font(.headline)
                .foregroundColor(.secondary)
            List {
                ForEach(setCollections, id: \.self) { setCollection in
                    // Using Instruments to inspect code runtime leads to very interesting observations
                    SetCollectionDisclosure(setCollection: setCollection)
                }
                .id(UUID())
            }
        }
    }
}
