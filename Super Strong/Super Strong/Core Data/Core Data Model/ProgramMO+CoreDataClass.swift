//
//  ProgramMO+CoreDataClass.swift
//  Super Strong
//
//  Created by Sawyer Nye on 11/11/20.
//
//

import Foundation
import CoreData

@objc(ProgramMO)
public class ProgramMO: NSManagedObject, Decodable {    
    private enum CodingKeys: String, CodingKey {
        case bench1RM
        case currentDay
        case currentWeek
        case daysPer
        case deadlift1RM
        case overheadPress1RM
        case programName
        case squat1RM
        case weeksPer
        case user
        case workouts
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else {
            fatalError("Error. No object context")
        }
        let entity = NSEntityDescription.entity(forEntityName: "ProgramMO", in: context)!
        self.init(entity: entity, insertInto: context)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        currentDay = try values.decodeIfPresent(Int64.self, forKey: .currentDay) ?? 1
        currentWeek = try values.decodeIfPresent(Int64.self, forKey: .currentWeek) ?? 1
        daysPer = try values.decode(Int64.self, forKey: .daysPer)
        programName = try values.decode(String.self, forKey: .programName)
        weeksPer = try values.decode(Int64.self, forKey: .weeksPer)
        workouts = try values.decode(Set<WorkoutMO>.self, forKey: .workouts)
        //workouts.forEach { $0.program = self }
        
    }
}
