//
//  ExerciseMO+CoreDataProperties.swift
//  Super Strong
//
//  Created by Sawyer Nye on 11/30/20.
//
//

import Foundation
import CoreData


extension ExerciseMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseMO> {
        return NSFetchRequest<ExerciseMO>(entityName: "ExerciseMO")
    }

    @NSManaged public var exerciseNumber: Int64
    @NSManaged public var note: String
    @NSManaged public var lift: LiftMO
    @NSManaged public var setCollections: Set<SetCollectionMO>
    @NSManaged public var workout: WorkoutMO

}

// MARK: Generated accessors for setCollections
extension ExerciseMO {

    @objc(addSetCollectionsObject:)
    @NSManaged public func addToSetCollections(_ value: SetCollectionMO)

    @objc(removeSetCollectionsObject:)
    @NSManaged public func removeFromSetCollections(_ value: SetCollectionMO)

    @objc(addSetCollections:)
    @NSManaged public func addToSetCollections(_ values: NSSet)

    @objc(removeSetCollections:)
    @NSManaged public func removeFromSetCollections(_ values: NSSet)

}

extension ExerciseMO : Identifiable {

}
