//
//  SwiftUINavigationStackView.swift
//  bootcamp-swiftui
//
//  Created by Robert Sandru on 09.11.2022.
//

import SwiftUI

struct SwiftUINavigationStackView: View {
    
    private(set) var parks: [Park] = []
    
    var body: some View {
        NavigationStack {
            List(parks) { park in
                NavigationLink(park.name, value: park)
            }
            .navigationDestination(for: Park.self) { park in
                Text(park.name)
            }
        }
    }
}

struct Park: Identifiable, Hashable {
    
    let id: UUID
    let name: String
}

fileprivate struct SwiftUINavigationStackPreviewWrapper: View {
    
    private(set) var parks: [Park] = [
        .init(id: UUID(), name: "Regina Maria Park"),
        .init(id: UUID(), name: "Parcul Poporului")
    ]
    
    var body: some View {
        SwiftUINavigationStackView(parks: parks)
    }
}

struct SwiftUINavigationStackView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUINavigationStackPreviewWrapper()
    }
}
