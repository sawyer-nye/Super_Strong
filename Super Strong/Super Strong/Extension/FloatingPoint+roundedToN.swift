//
//  RoundToNearest.swift
//  Super Strong
//
//  Created by Sawyer Nye on 11/21/20.
//

import Foundation

extension FloatingPoint {
    func rounded(to n: Int) -> Self {
        let n = Self(n)
        return (self / n).rounded() * n
    }
}
