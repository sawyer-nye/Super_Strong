//
//  SetCollectionDisclosure.swift
//  Super Strong
//
//  Created by Sawyer Nye on 12/13/20.
//

import SwiftUI

struct SetCollectionDisclosure: View {
    @ObservedObject var setCollection: SetCollectionMO
    
    var disclosureText: String {
        var output = "\(setCollection.setCollectionNumber): \(setCollection.sets)x\(setCollection.reps)"
        if setCollection.hasPlusSet { output += "+ " }
        if setCollection.percentage1RM != 0.0 {
            output += "@ \(setCollection.percentage1RM * 100)%"
        }
        
        return output
    }
    
    var body: some View {
        DisclosureGroup(disclosureText) {
            HStack {
                SetCollectionView(setCollection: setCollection)
                SetCollectionActions(setCollection: setCollection)
            }
            .padding(.vertical)
        }
    }
}
