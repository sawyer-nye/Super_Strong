//
//  WorkoutMO+CoreDataProperties.swift
//  Super Strong
//
//  Created by Sawyer Nye on 11/11/20.
//
//

import Foundation
import CoreData


extension WorkoutMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutMO> {
        return NSFetchRequest<WorkoutMO>(entityName: "WorkoutMO")
    }

    @NSManaged public var name: String?
    @NSManaged public var day: Int64
    @NSManaged public var week: Int64
    @NSManaged public var workoutType: String?
    @NSManaged public var exercises: Set<ExerciseMO>
    @NSManaged public var program: ProgramMO?
    @NSManaged public var finishDate: Date?

}

// MARK: Generated accessors for exercises
extension WorkoutMO {

    @objc(addExercisesObject:)
    @NSManaged public func addToExercises(_ value: ExerciseMO)

    @objc(removeExercisesObject:)
    @NSManaged public func removeFromExercises(_ value: ExerciseMO)

    @objc(addExercises:)
    @NSManaged public func addToExercises(_ values: NSSet)

    @objc(removeExercises:)
    @NSManaged public func removeFromExercises(_ values: NSSet)

}

extension WorkoutMO : Identifiable {

}
