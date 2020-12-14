//
//  SetCollectionActions.swift
//  Super Strong
//
//  Created by Sawyer Nye on 12/12/20.
//

import SwiftUI

struct SetCollectionActions: View {
    @EnvironmentObject var creationManager: ProgramCreationManager
    @ObservedObject var setCollection: SetCollectionMO
    
    @State var revealOptions: Bool = false
    
    var exercise: ExerciseMO { setCollection.exercise }
    
    var setCollections: [SetCollectionMO] {
        exercise.setCollections.sorted {
            $0.setCollectionNumber < $1.setCollectionNumber
        }
    }
    
    var setCollectionIsFirst: Bool {
        setCollection == setCollections.first
    }
    
    var setCollectionIsLast: Bool {
        setCollection == setCollections.last
    }
    
    var body: some View {
        VStack {
            if revealOptions {
                Spacer()
                Button(action: {
                    creationManager.insertNewSetCollection(for: exercise)
                    revealOptions = false
                }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(setCollectionIsLast ? Color(.systemGreen) : Color(.gray))
                        .font(.system(size: 16))
                }
                .disabled(!setCollectionIsLast)
                
                Spacer()
                Button(action: { revealOptions = false }) {
                    Image(systemName: "pencil.circle")
                        .font(.system(size: 16))
                }
                Spacer()
                
                Button(action: {
                    creationManager.deleteSetCollection(setCollection: setCollection, for: exercise)
                    revealOptions = false
                }) {
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(setCollectionIsFirst ? Color(.gray) : Color(.systemRed))
                        .font(.system(size: 16))
                }
                .disabled(setCollectionIsFirst)
                Spacer()
            } else {
                Button(action: { revealOptions = true }) {
                    Image(systemName: "pencil.circle.fill")
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.trailing)
    }
}
