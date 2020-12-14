//
//  ProgramView.swift
//  Super Strong
//
//  Created by Sawyer Nye on 12/4/20.
//

import SwiftUI
import CoreData

struct ProgramView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var user: UserMO
    @ObservedObject var program: ProgramMO
    
    @State var programSquat1RM: Int64 = 0
    @State var programBench1RM: Int64 = 0
    @State var programDeadlift1RM: Int64 = 0
    @State var programOverheadPress1RM: Int64 = 0
    
    func setAsCurrentProgram() {
        user.currentProgram = program
        
        if program.squat1RM != 0 {
            user.squat1RM = program.squat1RM
        }
        if program.bench1RM != 0 {
            user.bench1RM = program.bench1RM
        }
        if program.deadlift1RM != 0 {
            user.deadlift1RM = program.deadlift1RM
        }
        if program.overheadPress1RM != 0 {
            user.overheadPress1RM = program.overheadPress1RM
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Details")) {
                VStack(alignment: .leading) {
                    Text(program.programName)
                        .font(.title)
                        .bold()
                        .foregroundColor(.primary)
                    Text("Weeks: \(program.weeksPer)")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text("Days: \(program.daysPer)")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
            }
            Section(header: Text("Maxes")) {
                MaxSteppers(program: program)
                Button(action: {
                    setAsCurrentProgram()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Set program as active program with above maxes")
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
    }
}
