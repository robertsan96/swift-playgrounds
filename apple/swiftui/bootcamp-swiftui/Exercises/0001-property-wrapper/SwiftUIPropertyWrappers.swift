//
//  SwiftUIPropertyWrappers.swift
//  bootcamp-swiftui
//
//  Created by Robert Sandru on 08.11.2022.
//

import SwiftUI

struct SwiftUIPropertyWrappers: View {
    var body: some View {
        List {
            NavigationLink("@ObservedObject", destination: { SwiftUIObservedObject() })
            NavigationLink("@StateObject", destination: { SwiftUIStateObject() })
            NavigationLink("MVVM Examples", destination: { SwiftUIMVVM() })
        }
    }
}

struct SwiftUIPropertyWrappers_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIPropertyWrappers()
    }
}
