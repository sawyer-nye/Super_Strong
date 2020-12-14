//
//  UserMO+CoreDataProperties.swift
//  Super Strong
//
//  Created by Sawyer Nye on 12/8/20.
//
//

import Foundation
import CoreData


extension UserMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserMO> {
        return NSFetchRequest<UserMO>(entityName: "UserMO")
    }

    @NSManaged public var completedWorkouts: Set<WorkoutMO>
    @NSManaged public var currentProgram: ProgramMO?
    
    @NSManaged public var squat1RM: Int64
    @NSManaged public var bench1RM: Int64
    @NSManaged public var deadlift1RM: Int64
    @NSManaged public var overheadPress1RM: Int64
    @NSManaged public var startDate: Date
    
}

// MARK: Generated accessors for completedWorkouts
extension UserMO {

    @objc(addCompletedWorkoutsObject:)
    @NSManaged public func addToCompletedWorkouts(_ value: WorkoutMO)

    @objc(removeCompletedWorkoutsObject:)
    @NSManaged public func removeFromCompletedWorkouts(_ value: WorkoutMO)

    @objc(addCompletedWorkouts:)
    @NSManaged public func addToCompletedWorkouts(_ values: NSSet)

    @objc(removeCompletedWorkouts:)
    @NSManaged public func removeFromCompletedWorkouts(_ values: NSSet)

}

extension UserMO : Identifiable {

}
