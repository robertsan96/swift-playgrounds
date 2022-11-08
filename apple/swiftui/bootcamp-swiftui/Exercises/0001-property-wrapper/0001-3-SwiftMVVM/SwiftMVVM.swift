//
//  SwiftMVVM.swift
//  bootcamp-swiftui
//
//  Created by Robert Sandru on 08.11.2022.
//

import SwiftUI

struct SwiftMVVM: View {
    var body: some View {
        List {
            NavigationLink("Passing the view model to children", destination: { PassingViewModelToChildren() })
        }
    }
}

fileprivate

struct SwiftMVVM_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SwiftMVVM()
        }
    }
}
