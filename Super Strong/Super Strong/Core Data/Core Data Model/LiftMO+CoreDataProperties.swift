//
//  LiftMO+CoreDataProperties.swift
//  Super Strong
//
//  Created by Sawyer Nye on 11/11/20.
//
//

import Foundation
import CoreData


extension LiftMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LiftMO> {
        return NSFetchRequest<LiftMO>(entityName: "LiftMO")
    }

    @NSManaged public var primaryMuscleGroup: String
    @NSManaged public var liftName: String
    @NSManaged public var secondaryMuscleGroups: [String]?
    
}

extension LiftMO : Identifiable {

}
