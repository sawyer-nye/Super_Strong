//
//  HalfBar.swift
//  Super Strong
//
//  Created by Sawyer Nye on 12/10/20.
//

import SwiftUI

struct HalfBar: View {
    @Environment(\.colorScheme) var colorScheme
    
    var imageName: String
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack(alignment: .center) {
                    Image(systemName: imageName)
                        .font(.system(size: 32))
                        .foregroundColor(.primary)
                }
                Spacer()
            }
            .padding()
        }
        .background(
            colorScheme == .dark ? Color(.secondarySystemBackground) : Color(.systemBackground)
        )
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }
}

struct HalfBar_Previews: PreviewProvider {
    static var previews: some View {
        HalfBar(imageName: "calendar")
    }
}
