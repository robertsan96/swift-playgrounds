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
            NavigationLink("Swift @ObservedObject", destination: { SwiftObservedObject() })
            NavigationLink("Swift @StateObject", destination: { SwiftStateObject() })
        }
    }
}

struct SwiftPropertyWrappers_Previews: PreviewProvider {
    static var previews: some View {
        SwiftPropertyWrappers()
    }
}
