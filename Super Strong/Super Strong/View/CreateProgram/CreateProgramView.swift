//
//  CreateProgramView.swift
//  Super Strong
//
//  Created by Sawyer Nye on 12/11/20.
//

import SwiftUI

struct CreateProgramView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var user: UserMO
    @ObservedObject var creationManager = ProgramCreationManager()
    
    @State var programName: String = ""
    @State var squat1RM: String = ""
    @State var bench1RM: String = ""
    @State var deadlift1RM: String = ""
    @State var overheadPress1RM: String = ""
    
    @State var weeksPer: String = ""
    @State var daysPer: String = ""
    
    @State private var failedToInitialize = false
    
    func initializeProgram() {
        if !programName.isEmpty,
           let weeksPerProgram = Int64(weeksPer),
           let daysPerProgram = Int64(daysPer)
        {
            creationManager.initializeProgram(user: user, programName,
                                              weeksPer: weeksPerProgram,
                                              daysPer: daysPerProgram)
        } else {
            failedToInitialize = true
        }
    }
    
    func commitProgram() {
        creationManager.commitProgram()
        programName = ""
        squat1RM = ""
        bench1RM = ""
        deadlift1RM = ""
        overheadPress1RM = ""
        weeksPer = ""
        daysPer = ""
    }
    
    var week1Workouts: [WorkoutMO] {
        if let program = creationManager.program {
            return program.workouts.filter { $0.week == 1 }
        }
        return []
    }
    
    var detailsSection: some View {
        Section(header: Text("Enter Program Details")) {
            TextField("Program name", text: $programName)
            TextField("How many weeks?", text: $weeksPer)
                .keyboardType(.numberPad)
            TextField("How many days per week?", text: $daysPer)
                .keyboardType(.numberPad)
        }
    }
    
    var body: some View {
        Form {
            detailsSection
            if let program = creationManager.program {
                Section(header: Text("Set Weekly Workouts")) {
                    ForEach(1 ..< Int(program.weeksPer)+1) { weekNumber in
                        NavigationLink(destination: CreateWorkoutsView(user: user, weekNumber: Int64(weekNumber))) {
                            HStack {
                                Spacer()
                                Text("Week \(weekNumber) Workouts")
                                Spacer()
                            }
                        }
                    }
                    .id(UUID())
                    DuplicateWeek1Button()
                }
            } else {
                Button(action: { initializeProgram(); self.hideKeyboard() }) {
                    HStack {
                        Spacer()
                        Text("Initialize Program")
                        Spacer()
                    }
                }
            }
            if let _ = creationManager.program {
                Button(action: commitProgram) {
                    HStack {
                        Spacer()
                        Text("Commit Program")
                        Spacer()
                    }
                }
            }
        }
        .environmentObject(creationManager)
        .alert(isPresented: $failedToInitialize) {
            Alert(title: Text("Failed to Initialize Program"),
                  message: Text("Enter the program name, followed by number of weeks and number of days."),
                  dismissButton: .default(Text("Got it!")))
        }
        .navigationBarHidden(true)
    }
}
