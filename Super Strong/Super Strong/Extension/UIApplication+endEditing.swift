//
//  UIApplication+endEditing.swift
//  Super Strong
//
//  Created by Sawyer Nye on 11/22/20.
//

import SwiftUI

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter { $0.isKeyWindow }
            .first?
            .endEditing(force)
    }
}
