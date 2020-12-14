//
//  ExerciseMO+CoreDataClass.swift
//  Super Strong
//
//  Created by Sawyer Nye on 11/30/20.
//
//

import Foundation
import CoreData

@objc(ExerciseMO)
public class ExerciseMO: NSManagedObject, Decodable {
    private enum CodingKeys: String, CodingKey {
        case exerciseNumber
        case note
        case liftName
        case setCollections
        case workout
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else {
            fatalError("NSManagedObjectContext is missing")
        }
        let entity = NSEntityDescription.entity(forEntityName: "ExerciseMO", in: context)!
        self.init(entity: entity, insertInto: context)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        exerciseNumber = try values.decode(Int64.self, forKey: .exerciseNumber)
        
        let liftName = try values.decode(String.self, forKey: .liftName)
        let existingLift = try? context.fetch(LiftMO.fetchRequest()).filter {
            $0.liftName == liftName
        }
        if existingLift != nil && !existingLift!.isEmpty {
            lift = existingLift!.first!
        } else {
            lift = LiftMO(context: context)
            lift.liftName = liftName
            lift.primaryMuscleGroup = ""
            lift.secondaryMuscleGroups = []
            print("Inserting a new lift into LiftDB... \(liftName)")
        }
        
        setCollections = try values.decode(Set<SetCollectionMO>.self, forKey: .setCollections)
        //setCollections.forEach { $0.exercise = self }
    }
}
