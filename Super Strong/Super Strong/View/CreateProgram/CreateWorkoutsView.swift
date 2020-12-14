//
//  CreateWorkoutsView.swift
//  Super Strong
//
//  Created by Sawyer Nye on 12/11/20.
//

import SwiftUI

struct CreateWorkoutsView: View {
    @EnvironmentObject var creationManager: ProgramCreationManager
    
    @ObservedObject var user: UserMO
    
    let weekNumber: Int64
    
    var program: ProgramMO? {
        if let currentProgram = creationManager.program {
            return currentProgram
        } else {
            return nil
        }
    }
    
    var workouts: [WorkoutMO] {
        let workoutsOfWeek = program!.workouts.filter {
            $0.week == weekNumber
        }
        return workoutsOfWeek.sorted {
            ($0.week, $0.day) < ($1.week, $1.day)
        }
    }
    
    var body: some View {
        TabView {
            ForEach(workouts.indices) { idx in
                CreateWorkoutView(workout: workouts[idx])
                    .environmentObject(creationManager)
                    .navigationBarTitle("Week \(weekNumber) Workouts", displayMode: .inline)
                    .tabItem {
                        Image(systemName: "\(idx+1).circle.fill")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .tag(idx)
            }
            .id(UUID())
        }
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .tabViewStyle(PageTabViewStyle())
    }
}
