//
//  SwiftPropertyWrappers.swift
//  bootcamp-swiftui
//
//  Created by Robert Sandru on 08.11.2022.
//

import SwiftUI

struct SwiftPropertyWrappers: View {
    var body: some View {
        List {
            NavigationLink("Swift Observed Object", destination: { SwiftObservedObject() })
        }
    }
}

struct SwiftPropertyWrappers_Previews: PreviewProvider {
    static var previews: some View {
        SwiftPropertyWrappers()
    }
}
