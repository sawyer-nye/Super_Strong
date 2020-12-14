//
//  WorkoutsView.swift
//  Super Strong
//
//  Created by Sawyer Nye on 11/11/20.
//

import SwiftUI
import CoreData

struct WorkoutsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var user: UserMO
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \WorkoutMO.week, ascending: true),
                                    NSSortDescriptor(keyPath: \WorkoutMO.day, ascending: true)])
    private var workouts: FetchedResults<WorkoutMO>
    
    var quickWorkouts: [WorkoutMO] {
        workouts.filter { $0.program == nil }
    }
    
    func getNextWorkout() -> WorkoutMO? {
        if let program = user.currentProgram {
            let currentWeek = program.currentWeek
            let currentDay = program.currentDay
            return program.workouts.filter { $0.week == currentWeek && $0.day == currentDay }.first ?? nil
        }
        return nil
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVStack {
                    VStack(alignment: .leading) {
                        Text("Current Program")
                            .font(.title)
                            .foregroundColor(.primary)
                            .padding(.leading)
                        if getNextWorkout() != nil {
                            HStack {
                                Spacer()
                                WorkoutCard(workout: getNextWorkout()!, user: user, width: geometry.size.width - 60)
                                Spacer()
                            }
                        } else {
                            Text("You do not have a current program selected. Please select one on the Profile tab.")
                                .padding()
                        }
                        Text("Quick Workouts")
                            .font(.title)
                            .foregroundColor(.primary)
                            .padding(.leading)
                        ScrollView() {
                            VStack {
                                ForEach(quickWorkouts) { workout in
                                    HStack {
                                        Spacer()
                                        WorkoutCard(workout: workout, user: user, width: geometry.size.width - 60)
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding(.vertical)
        .navigationBarHidden(true)
    }
}
