//
//  LiftView.swift
//  Super Strong
//
//  Created by Sawyer Nye on 12/7/20.
//

import SwiftUI

struct LiftView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var lift: LiftMO
    
    @State var editingPrimaryGroup: Bool = false
    @State var newGroupName: String = ""
    
    var secondaryGroups: [String] {
        Array(lift.secondaryMuscleGroups ?? [])
    }
    
    func addSecondaryGroup() {
        if newGroupName != "" {
            if secondaryGroups.isEmpty {
                lift.secondaryMuscleGroups = []
            }
            lift.secondaryMuscleGroups?.append(newGroupName)
            try? viewContext.save()
        }
    }
    
    func removeSecondaryGroup(with name: String) {
        lift.secondaryMuscleGroups?.removeAll { $0 == name }
        try? viewContext.save()
    }
    
    var primaryGroupsSection: some View {
        Section(header: Text("Primary Muscle Group")) {
            if editingPrimaryGroup {
                TextField("Enter New Muscle Group", text: $lift.primaryMuscleGroup)
            } else {
                Text(lift.primaryMuscleGroup)
            }
            Button(action: { editingPrimaryGroup.toggle() }) {
                HStack {
                    Spacer()
                    if editingPrimaryGroup {
                        Text("Done Editing")
                    } else {
                        Text("Edit Primary Muscle Group")
                    }
                    Spacer()
                }
            }
        }
    }
    
    var secondaryGroupsSection: some View {
        Section(header: Text("Secondary Muscle Groups")) {
            ForEach(secondaryGroups, id: \.self) { muscleGroup in
                HStack {
                    Text(muscleGroup)
                    Spacer()
                    Button(action: { removeSecondaryGroup(with: muscleGroup) }) {
                        Image(systemName: "trash.fill")
                            .foregroundColor(Color(.systemRed))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            TextField("Enter New Muscle Group", text: $newGroupName)
            Button(action: { addSecondaryGroup(); newGroupName = "" }) {
                HStack {
                    Spacer()
                    Text("Add Muscle Group")
                    Spacer()
                }
            }
        }
    }
    
    var body: some View {
        Form {
            primaryGroupsSection
            secondaryGroupsSection
        }
        .navigationBarTitle(lift.liftName)
    }
}
