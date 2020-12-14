//
//  JSONDecoder+NSManagedInit.swift
//  Super Strong
//
//  Created by Sawyer Nye on 12/2/20.
//
//  source: https://stackoverflow.com/questions/61479842/decoding-json-nested-dictionary-using-decodable-and-storing-it-using-core-data

import Foundation
import CoreData

extension JSONDecoder {
    convenience init(context: NSManagedObjectContext) {
        self.init()
        self.userInfo[.context] = context
    }
}
