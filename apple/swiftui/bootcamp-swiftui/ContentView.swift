//
//  ContentView.swift
//  bootcamp-swiftui
//
//  Created by Robert Sandru on 07.11.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Section("Flows") {
                    NavigationLink("0001 - Ecommerce Flow", destination: {
                        EcommerceFlow().navigationTitle("Ecommerce Flow")
                    })
                }
                Section("Exercises") {
                    NavigationLink("0001 - Property Wrappers", destination: {
                        SwiftPropertyWrappers()
                    })
                }
            }
            .navigationTitle("SwiftUI Bootcamp")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
