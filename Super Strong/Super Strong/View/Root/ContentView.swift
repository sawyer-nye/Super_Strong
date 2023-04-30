//
//  ContentView.swift
//  Super Strong
//
//  Created by Sawyer Nye on 11/10/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: UserMO.entity(), sortDescriptors: [])
    private var users: FetchedResults<UserMO>
    
    var body: some View {
        TabView {
            if !users.isEmpty {
                NavigationView {
                    WorkoutsView(user: users[0])
                }
                .navigationViewStyle(.stack)
                .tabItem {
                    Image(systemName: "hammer.fill")
                    Text("Workout")
                }
                
                UserProgressView(user: users[0])
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Progress")
                }
                
                NavigationView {
                    CreateProgramView(user: users[0])
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    Image(systemName: "plus.square.fill")
                    Text("Create")
                }
                
                NavigationView {
                    LiftDbView(dbMode: .standard, selectedLift: nil)
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    Image(systemName: "table.fill")
                    Text("LiftDb")
                }
                
                NavigationView {
                    ProfileView(user: users[0])
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Profile")
                }
            } else {
                EmptyView()
                    .tabItem { Text("") }
            }
        }
        .onAppear {
            // Uncomment to see Application Support directory path (for preloading data as SQLite)
            //print(FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0])
            
            let alreadyLoadedKey = "AlreadyLoaded"
            let userDefaults = UserDefaults.standard
            let alreadyLoaded = userDefaults.bool(forKey: alreadyLoadedKey)
            
            if !alreadyLoaded {
                createDefaultUser()
                loadData()
                loadProgramsFromJSON()
                loadQuickWorkoutsFromJSON()
            }
            userDefaults.set(true, forKey: alreadyLoadedKey)
            userDefaults.synchronize()
        }
    }
    
    private func createDefaultUser() {
        let user = UserMO(context: viewContext)
        user.startDate = Date()
        try? viewContext.save()
    }
    
    private func loadProgramsFromJSON() {
        let filenames = ["fiveThreeOne", "disbrowBench"]
        
        for filename in filenames {
            if let fileURL = Bundle.main.url(forResource: filename, withExtension: "json") {
                let data = try? Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                decoder.userInfo[.context] = viewContext
                
                if data != nil {
                    do {
                        _ = try decoder.decode(ProgramMO.self, from: data!)
                    } catch {
                        print("error: \(error)")
                    }
                }
            }
        }
        try? viewContext.save()
    }
    
    private func loadQuickWorkoutsFromJSON() {
        let filenames = ["bigLegDay", "quickShoulderDay", "bigBootyDay"]
        
        for filename in filenames {
            if let fileURL = Bundle.main.url(forResource: filename, withExtension: "json") {
                let data = try? Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                decoder.userInfo[.context] = viewContext
                
                if data != nil {
                    do {
                        _ = try decoder.decode(WorkoutMO.self, from: data!)
                    } catch {
                        print("error: \(error)")
                    }
                }
            }
        }
        try? viewContext.save()
    }
    
    // A sampling of programmatic workout creation
    private func loadData() {        
        let workout = WorkoutMO(context: viewContext)
        workout.week = 0
        workout.day = 0
        workout.workoutType = "Upper Body"
        
        let exercise_bench = ExerciseMO(context: viewContext)
        let lift_bench = try? viewContext.fetch(LiftMO.fetchRequest())
            .filter { $0.liftName == "Bench Press" }
            .first!
        
        let sets_bench = SetCollectionMO(context: viewContext)
        sets_bench.sets = 3
        sets_bench.reps = 6
        exercise_bench.addToSetCollections(sets_bench)
        exercise_bench.exerciseNumber = 1
        exercise_bench.lift = lift_bench!
        
        let exercise_inclineBench = ExerciseMO(context: viewContext)
        let lift_inclineBench = LiftMO(context: viewContext)
        lift_inclineBench.liftName = "Barbell Incline Bench Press"
        lift_inclineBench.primaryMuscleGroup = "Chest"
        lift_inclineBench.secondaryMuscleGroups = ["Triceps", "Front Deltoids"]
        let sets_inclineBench = SetCollectionMO(context: viewContext)
        sets_inclineBench.sets = 4
        sets_inclineBench.reps = 10
        exercise_inclineBench.addToSetCollections(sets_inclineBench)
        exercise_inclineBench.exerciseNumber = 2
        exercise_inclineBench.lift = lift_inclineBench
        
        let exercise_dbFly = ExerciseMO(context: viewContext)
        let lift_dbFly = LiftMO(context: viewContext)
        lift_dbFly.liftName = "Dumbbell Fly"
        lift_dbFly.primaryMuscleGroup = "Chest"
        let sets_dbFly = SetCollectionMO(context: viewContext)
        sets_dbFly.sets = 1
        sets_dbFly.reps = 50
        exercise_dbFly.addToSetCollections(sets_dbFly)
        exercise_dbFly.exerciseNumber = 3
        exercise_dbFly.lift = lift_dbFly
        
        workout.name = "Simple Chest Day"
        workout.addToExercises([exercise_bench, exercise_inclineBench, exercise_dbFly])
         
        do {
            try viewContext.save()
        } catch {
            print("ERROR: \(error)")
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
