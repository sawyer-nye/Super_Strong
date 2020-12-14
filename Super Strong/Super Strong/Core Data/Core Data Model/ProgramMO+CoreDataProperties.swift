//
//  ProgramMO+CoreDataProperties.swift
//  Super Strong
//
//  Created by Sawyer Nye on 11/11/20.
//
//

import Foundation
import CoreData

/**
    - A Program has a set of workouts; there exists one workout for each day of each week
    - A Workout has Main lifts (Squat, Bench, Deadlift) and Accessory lifts
    - Main lifts points to associated exercises
    - Accessory lifts points to associated exercises
 */

extension ProgramMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProgramMO> {
        return NSFetchRequest<ProgramMO>(entityName: "ProgramMO")
    }

    @NSManaged public var programName: String
    @NSManaged public var squat1RM: Int64
    @NSManaged public var bench1RM: Int64
    @NSManaged public var deadlift1RM: Int64
    @NSManaged public var overheadPress1RM: Int64
    @NSManaged public var workouts: Set<WorkoutMO>
    @NSManaged public var currentWeek: Int64
    @NSManaged public var currentDay: Int64
    @NSManaged public var weeksPer: Int64
    @NSManaged public var daysPer: Int64

}

// MARK: Generated accessors for workouts
extension ProgramMO {

    @objc(addWorkoutsObject:)
    @NSManaged public func addToWorkouts(_ value: WorkoutMO)

    @objc(removeWorkoutsObject:)
    @NSManaged public func removeFromWorkouts(_ value: WorkoutMO)

    @objc(addWorkouts:)
    @NSManaged public func addToWorkouts(_ values: NSSet)

    @objc(removeWorkouts:)
    @NSManaged public func removeFromWorkouts(_ values: NSSet)

}

extension ProgramMO : Identifiable {

}
