//
//  SwiftUINavigationView.swift
//  bootcamp-swiftui
//
//  Created by Robert Sandru on 09.11.2022.
//

import SwiftUI

struct SwiftUINavigationView: View {
    var body: some View {
        List {
            NavigationLink("Navigation Stack", destination: { SwiftUIObservedObject() })
        }
    }
}

struct SwiftUINavigationView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUINavigationView()
    }
}
