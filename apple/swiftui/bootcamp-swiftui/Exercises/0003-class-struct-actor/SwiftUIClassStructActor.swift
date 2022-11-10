//
//  SwiftUIClassStructActor.swift
//  bootcamp-swiftui
//
//  Created by Robert Sandru on 09.11.2022.
//

import SwiftUI

struct SwiftUIClassStructActor: View {
    var body: some View {
        List {
            NavigationLink("Actors", destination: { SwiftUIActors() })
            NavigationLink("Actors + Race Conditions", destination: { SwiftUIActorsRaceCondition() })
        }
    }
}

struct SwiftUIClassStructActor_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIClassStructActor()
    }
}
