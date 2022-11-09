//
//  ContentView.swift
//  bootcamp-swiftui
//
//  Created by Robert Sandru on 07.11.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var bootcampTabViewOneActiveTab = 0
    @State private var bootcampTabViewOneTabs: [TabViewElement] = []
    
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
                        SwiftUIPropertyWrappers()
                    })
                    NavigationLink("0002 - Navigation Stack", destination: {
                        SwiftUINavigationView()
                    })
                    NavigationLink("0003 - Classes, Structs & Actors", destination: {
                        SwiftUIClassStructActor()
                    })
                }
                Section("Components") {
                    NavigationLink("0001 - BootcampTabViewOne", destination: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.cyan.opacity(0.15))
                                .ignoresSafeArea()
                            VStack {
                                BootcampTabViewOnePreviewHelper(tabs: $bootcampTabViewOneTabs,
                                                                activeTab: $bootcampTabViewOneActiveTab)
                                Spacer()
                                BootcampTabViewOne(tabs: bootcampTabViewOneTabs,
                                                   activeTab: $bootcampTabViewOneActiveTab)
                                    .frame(height: 70)
                                    .padding()
                            }
                        }
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
