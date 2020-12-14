//
//  SetCollectionMO+CoreDataProperties.swift
//  Super Strong
//
//  Created by Sawyer Nye on 11/30/20.
//
//

import Foundation
import CoreData


extension SetCollectionMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SetCollectionMO> {
        return NSFetchRequest<SetCollectionMO>(entityName: "SetCollectionMO")
    }

    @NSManaged public var setCollectionNumber: Int64
    @NSManaged public var isComplete: Bool
    @NSManaged public var hasPlusSet: Bool
    @NSManaged public var percentage1RM: Float
    @NSManaged public var reps: Int64
    @NSManaged public var sets: Int64
    @NSManaged public var exercise: ExerciseMO
    
}

extension SetCollectionMO : Identifiable {

}
