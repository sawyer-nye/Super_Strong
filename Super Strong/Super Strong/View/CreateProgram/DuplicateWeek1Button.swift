//
//  DuplicateWeek1Button.swift
//  Super Strong
//
//  Created by Sawyer Nye on 12/13/20.
//

import SwiftUI

struct DuplicateWeek1Button: View {
    @EnvironmentObject var creationManager: ProgramCreationManager
    
//    var firstWeekNotEmpty: Bool {
//        if let firstWeek = creationManager.program?.workouts.filter({ $0.week == 1 }) {
//            return firstWeek.allSatisfy { !$0.exercises.isEmpty }
//        }
//        return false
//    }
//    
//    var otherWeeksEmpty: Bool {
//        if let otherWeeks = creationManager.program?.workouts.filter({ $0.week != 1 }) {
//            return otherWeeks.allSatisfy { $0.exercises.isEmpty }
//        }
//        return false
//    }
//    
//    var canDuplicateFirstWeek: Bool {
//        return firstWeekNotEmpty && otherWeeksEmpty
//    }
    
    var body: some View {
        HStack {
            Spacer()
            Button("Duplicate week 1 to subsequent weeks") {
                creationManager.duplicateWeek1Workouts()
            }
            Spacer()
        }
    }
}
