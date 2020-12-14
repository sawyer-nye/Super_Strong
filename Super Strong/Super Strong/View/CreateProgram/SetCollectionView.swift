//
//  SetCollectionView.swift
//  Super Strong
//
//  Created by Sawyer Nye on 12/12/20.
//

import SwiftUI
import Combine

struct SetCollectionView: View {
    @Environment(\.colorScheme) var colorScheme

    @ObservedObject var setCollection: SetCollectionMO
    
    var percentage1RM: some View {
        HStack {
            if setCollection.percentage1RM != 0.0 {
                Text("Percent 1RM:")
                Slider(value: $setCollection.percentage1RM, in: 0.5...1, step: 0.010)
            }
        }
    }
    
    var setsAndReps: some View {
        HStack {
            VStack {
                HStack {
                    Text("Sets:")
                    Stepper("", value: $setCollection.sets, in: 1...15)
                }
                HStack {
                    Text("Reps:")
                    Stepper("", value: $setCollection.reps, in: 1...100)
                }
            }
            Spacer()
        }
    }
    
    var plusSet: some View {
        HStack {
            Text("Last set rep out?")
            Toggle("", isOn: $setCollection.hasPlusSet)
                .toggleStyle(SwitchToggleStyle())
                .labelsHidden()
            Spacer()
        }
    }
    
    var body: some View {
        VStack {
            percentage1RM
            setsAndReps
            plusSet
        }
        .padding()
        .font(.subheadline)
    }
}
