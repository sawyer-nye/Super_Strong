//
//  UserProgressView.swift
//  Super Strong
//
//  Created by Sawyer Nye on 11/22/20.
//

import SwiftUI
import CoreData
import RKCalendar

struct UserProgressView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var user: UserMO

    @ObservedObject var rkManager = RKManager(
        calendar: Calendar.current,
        minimumDate: Date().addingTimeInterval(-60*60*24*60),
        maximumDate: Date().addingTimeInterval(60*60*24*90),
        mode: .dateRange
    )
    
    @State private var revealWorkouts = false
    @State private var revealPrograms = false
    
    @State var revealModal = false
    
    func getTextFromDate(_ date: Date?) -> String {
        if date == nil { return "" }
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: date!)
    }
    
    func initializeRKManager() {
        rkManager.isVertical = false
        rkManager.isContinuous = false
        rkManager.minimumDate = user.startDate
    }
    
    var workoutsInSelectedRange: [WorkoutMO] {
        if let endDate = rkManager.endDate {
            return user.completedWorkouts.filter {
                ($0.finishDate! < endDate) && ($0.finishDate! > rkManager.startDate)
            }
        }
        return []
    }
    
    var programsInSelectedRange: Set<ProgramMO> {
        if let _ = rkManager.endDate {
            return Set(workoutsInSelectedRange.compactMap { $0.program })
        }
        return []
    }
    
    var actionBars: some View {
        HStack {
            Button(action: { revealModal = true }) {
                HalfBar(imageName: "calendar")
            }
            Spacer()
            // There just wasn't enough time...
            Button(action: {  }) {
                HalfBar(imageName: "chart.bar")
            }
        }
    }
    
    var datesSelection: some View {
        HStack {
            if rkManager.endDate != nil {
                Spacer()
                Text(getTextFromDate(rkManager.startDate)).bold()
                Text("-").bold()
                Text(getTextFromDate(rkManager.endDate)).bold()
                Spacer()
            } else {
                Spacer()
                Text("Select a range of dates with the calendar button.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
            }
        }
    }
    
    var dropdowns: some View {
        VStack {
            DisclosureGroup("Workouts in selected range: ", isExpanded: $revealWorkouts) {
                ForEach(workoutsInSelectedRange, id: \.self) { workout in
                    HStack {
                        Text(workout.program?.programName ?? "Unnamed Program").bold()
                        Text("Week: \(workout.week)")
                        Text("Day: \(workout.day)")
                        Spacer()
                    }
                }
            }
            DisclosureGroup("Programs in selected range: ", isExpanded: $revealPrograms) {
                ForEach(Array(programsInSelectedRange), id: \.self) { program in
                    HStack {
                        Text(program.programName).bold()
                        Spacer()
                    }
                }
            }
            Spacer()
        }
        .padding()
    }
    
    var calendarModal: some View {
        VStack {
            Spacer()
            RKCalendarView().environmentObject(rkManager)
            Button(action: { revealModal = false }) {
                Text("Done Selecting Dates")
            }
            .padding()
        }
    }
    
    var body: some View {
        VStack {
            MaxesBar(user: user)
            actionBars
            datesSelection
            dropdowns
            Spacer()
        }
        .sheet(isPresented: $revealModal) { calendarModal }
        .onAppear { initializeRKManager() }
        .onDisappear {
            revealWorkouts = false
            revealPrograms = false
        }
    }
}
