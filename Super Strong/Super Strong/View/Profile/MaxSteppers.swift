//
//  MaxSteppers.swift
//  Super Strong
//
//  Created by Sawyer Nye on 11/22/20.
//

import SwiftUI

struct MaxSteppers: View {
    @ObservedObject var program: ProgramMO
    
    var body: some View {
        VStack {
            Stepper(value: $program.squat1RM,
                    in: 45...1000,
                    step: 5
            ) {
                Text("Squat 1RM: \(program.squat1RM)")
            }
            Stepper(value: $program.bench1RM,
                    in: 45...1000,
                    step: 5
            ) {
                Text("Bench 1RM: \(program.bench1RM)")
            }
            Stepper(value: $program.deadlift1RM,
                    in: 45...1000,
                    step: 5
            ) {
                Text("Deadlift 1RM: \(program.deadlift1RM)")
            }
            Stepper(value: $program.overheadPress1RM,
                    in: 45...1000,
                    step: 5
            ) {
                Text("Overhead Press 1RM: \(program.overheadPress1RM)")
            }
        }
    }
}
