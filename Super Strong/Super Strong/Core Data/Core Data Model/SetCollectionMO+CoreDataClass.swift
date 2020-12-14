//
//  SetCollectionMO+CoreDataClass.swift
//  Super Strong
//
//  Created by Sawyer Nye on 11/30/20.
//
//

import Foundation
import CoreData

@objc(SetCollectionMO)
public class SetCollectionMO: NSManagedObject, Decodable {
    private enum CodingKeys: String, CodingKey {
        case hasPlusSet
        case isComplete
        case percentage1RM
        case reps
        case setCollectionNumber
        case sets
        case exercise
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else {
            fatalError("NSManagedObjectContext is missing")
        }
        let entity = NSEntityDescription.entity(forEntityName: "SetCollectionMO", in: context)!
        self.init(entity: entity, insertInto: context)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        hasPlusSet = try values.decodeIfPresent(Bool.self, forKey: .hasPlusSet) ?? false
        percentage1RM = try values.decodeIfPresent(Float.self, forKey: .percentage1RM) ?? 0.0
        reps = try values.decode(Int64.self, forKey: .reps)
        setCollectionNumber = try values.decodeIfPresent(Int64.self, forKey: .setCollectionNumber) ?? 1
        sets = try values.decodeIfPresent(Int64.self, forKey: .sets) ?? 1
    }
}
