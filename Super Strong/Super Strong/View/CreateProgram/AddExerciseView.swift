//
//  AddExerciseView.swift
//  Super Strong
//
//  Created by Sawyer Nye on 12/11/20.
//

import SwiftUI

struct AddExerciseView: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var creationManager: ProgramCreationManager
    
    @ObservedObject var workout: WorkoutMO
    @Binding var revealSheet: Bool
    @State var selectedLift: LiftMO? = nil
    
    @State var revealNewLiftSheet = false
        
    func addExerciseToWorkout() {
        if let selLift = selectedLift {
            creationManager.insertNewExercise(for: workout, with: selLift)
        }
    }
    
    var body: some View {
        VStack {
            LiftDbView(dbMode: .selectLift, selectedLift: $selectedLift)
                .frame(height: 300)
            Form {
                Section(header: Text("Can't find the lift you're looking for?")) {
                    HStack {
                        Spacer()
                        Button("Create New Lift") {
                            revealNewLiftSheet = true
                        }
                        Spacer()
                    }
                }
                Section(header: Text("Selected Lift:")) {
                    HStack {
                        Spacer()
                        Text(selectedLift?.liftName ?? "")
                        Spacer()
                    }
                }
                
                HStack {
                    Spacer()
                    Button("All Done") {
                        addExerciseToWorkout()
                        revealSheet = false
                    }
                    Spacer()
                }
            }
        }
        .sheet(isPresented: $revealNewLiftSheet) {
            AddLiftView(revealSheet: $revealNewLiftSheet)
                .environment(\.managedObjectContext, self.viewContext)
                .environmentObject(creationManager)
        }
    }
}
