//
//  WorkoutMO+CoreDataClass.swift
//  Super Strong
//
//  Created by Sawyer Nye on 11/11/20.
//
//

import Foundation
import CoreData

@objc(WorkoutMO)
public class WorkoutMO: NSManagedObject, Decodable {
    private enum CodingKeys: String, CodingKey {
        case day
        case finishDate
        case name
        case week
        case workoutType
        case exercises
        case program
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else {
            fatalError("NSManagedObjectContext is missing")
        }
        let entity = NSEntityDescription.entity(forEntityName: "WorkoutMO", in: context)!
        self.init(entity: entity, insertInto: context)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        day = try values.decodeIfPresent(Int64.self, forKey: .day) ?? 0
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        week = try values.decodeIfPresent(Int64.self, forKey: .week) ?? 0
        workoutType = try values.decodeIfPresent(String.self, forKey: .workoutType) ?? ""
        exercises = try values.decode(Set<ExerciseMO>.self, forKey: .exercises)
        //exercises.forEach { $0.workout = self }
    }
    
}
