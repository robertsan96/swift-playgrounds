//
//  SwiftMVVM.swift
//  bootcamp-swiftui
//
//  Created by Robert Sandru on 08.11.2022.
//

import SwiftUI

struct SwiftUIMVVM: View {
    var body: some View {
        List {
            NavigationLink("Passing the view model to children", destination: { PassingViewModelToChildren() })
        }
    }
}

fileprivate

struct SwiftUIMVVM_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SwiftUIMVVM()
        }
    }
}
