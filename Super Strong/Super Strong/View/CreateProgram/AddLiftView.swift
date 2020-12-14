//
//  AddLiftView.swift
//  Super Strong
//
//  Created by Sawyer Nye on 12/11/20.
//

import SwiftUI

struct AddLiftView: View {
    @EnvironmentObject var creationManager: ProgramCreationManager
    
    @Binding var revealSheet: Bool
    
    @State private var liftName = ""
    @State private var primaryMuscleGroup = ""
    @State private var secondaryMuscleGroups = ""
    
    @State var failedToAddLift = false
    
    func sanitizeAndInsertLift() {
        if liftName.isEmpty || primaryMuscleGroup.isEmpty {
            failedToAddLift = true
        } else {
            //sanitize?
            creationManager.insertNewLift(
                liftName: liftName,
                primaryMuscleGroup: primaryMuscleGroup,
                secondaryMuscleGroups: secondaryMuscleGroups.components(separatedBy: ", ")
            )
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Lift Name")) {
                TextField("", text: $liftName)
            }
            Section(header: Text("Primary Muscle Group")) {
                TextField("", text: $primaryMuscleGroup)
            }
            Section(header: Text("Secondary Muscle Groups [Separate by Comma]")) {
                TextField("", text: $secondaryMuscleGroups)
            }
            Button("Add Lift to LiftDB") {
                sanitizeAndInsertLift()
                revealSheet = false
            }
        }
        .alert(isPresented: $failedToAddLift) {
            Alert(title: Text("Failed to Add Lift"),
                  message: Text("Enter the lift name, primary muscle group, and secondary muscle groups [separated by comma]."),
                  dismissButton: .default(Text("Got it!")))
        }
    }
}
