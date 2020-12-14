//
//  OneRepMax.swift
//  Super Strong
//
//  Created by Sawyer Nye on 11/10/20.
//

import SwiftUI
import Combine

struct OneRepMax: View {
    @State var weightInput: String = ""
    @State var repsInput: String = ""
    
    var estOneRepMax: Int {
        if let doubleWeight = Double(weightInput) {
            if let doubleReps = Double(repsInput) {
                // magic formula! it really works!
                return Int(doubleWeight / (1.0278 - (0.0278 * doubleReps)))
            }
        }
        return 0
    }
    
    var body: some View {
        HStack {
            Text("Weight: ")
            TextField("", text: $weightInput)
                .onReceive(Just(weightInput)) { newValue in
                    let filtered = newValue.filter { "0123456789".contains($0) }
                    if filtered != newValue {
                        self.weightInput = filtered
                    }
                }
        }
        HStack {
            Text("Reps: ")
            TextField("", text: $repsInput)
                .onReceive(Just(repsInput)) { newValue in
                    let filtered = newValue.filter { "0123456789".contains($0) }
                    if filtered != newValue {
                        self.repsInput = filtered
                    }
                }
        }
        Text("1RM: \(estOneRepMax)")
    }
}
