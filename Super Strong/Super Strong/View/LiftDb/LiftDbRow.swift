//
//  LiftDbRow.swift
//  Super Strong
//
//  Created by Sawyer Nye on 12/4/20.
//

import SwiftUI

struct LiftDbRow: View {
    @ObservedObject var lift: LiftMO
    let parentWidth: CGFloat
    let dbMode: DbMode
    
    @Binding var selectedLift: LiftMO?
    
    var rowContent: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(lift.liftName)")
                        .font(.title2)
                        .foregroundColor(.primary)
                    Text("\(lift.primaryMuscleGroup)")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text("\(lift.secondaryMuscleGroups?.joined(separator: ", ") ?? "")")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
        }
        .padding()
        .frame(width: parentWidth - 40)
        .navigationBarHidden(true)
    }
    
    var body: some View {
        VStack {
            if dbMode == .standard {
                NavigationLink(destination: LiftView(lift: lift)) {
                    rowContent
                }
            } else {
                Button(action: { selectedLift = lift }) {
                    rowContent
                }
            }
        }
    }
}
