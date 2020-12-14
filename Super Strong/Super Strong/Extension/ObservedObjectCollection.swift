//
//  ObservedObjectCollection.swift
//  Super Strong
//
//  Created by Sawyer Nye on 11/16/20.
//  Source: https://stackoverflow.com/questions/57459727/why-an-observedobject-array-is-not-updated-in-my-swiftui-application/64524756#64524756
//  Why?
//  --> Using @ObservedObject will NOT refresh the view when a relation gets updated
//

/// NOTE: Deprecated at this point. Leaving in place in the case that I choose to re-include a progress bar on the workout page

import Combine
import SwiftUI

private class ObservedObjectCollectionBox<Element>: ObservableObject where Element: ObservableObject {
    private var subscription: AnyCancellable?
    
    init(_ wrappedValue: AnyCollection<Element>) {
        self.reset(wrappedValue)
    }
    
    func reset(_ newValue: AnyCollection<Element>) {
        self.subscription = Publishers.MergeMany(newValue.map { $0.objectWillChange })
            .eraseToAnyPublisher()
            .sink { _ in
                self.objectWillChange.send()
            }
    }
}

@propertyWrapper
public struct ObservedObjectCollection<Element>: DynamicProperty where Element: ObservableObject {
    @ObservedObject private var observed: ObservedObjectCollectionBox<Element>
    
    public init(wrappedValue: AnyCollection<Element>) {
        self.wrappedValue = wrappedValue
        self.observed = ObservedObjectCollectionBox(wrappedValue)
    }
    
    public init(wrappedValue: AnyCollection<Element>?) {
        self.init(wrappedValue: wrappedValue ?? AnyCollection([]))
    }
    
    public init<C: Collection>(wrappedValue: C) where C.Element == Element {
        self.init(wrappedValue: AnyCollection(wrappedValue))
    }
    
    public init<C: Collection>(wrappedValue: C?) where C.Element == Element {
        if let wrappedValue = wrappedValue {
            self.init(wrappedValue: wrappedValue)
        } else {
            self.init(wrappedValue: AnyCollection([]))
        }
    }
    
    public var wrappedValue: AnyCollection<Element> {
        didSet {
            if isKnownUniquelyReferenced(&observed) {
                self.observed.reset(wrappedValue)
            } else {
                self.observed = ObservedObjectCollectionBox(wrappedValue)
            }
        }
    }
}
