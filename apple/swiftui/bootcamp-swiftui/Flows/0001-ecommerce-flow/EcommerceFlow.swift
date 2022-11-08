//
//  EcommerceFlow.swift
//  bootcamp-swiftui
//
//  Created by Robert Sandru on 07.11.2022.
//

import SwiftUI

struct EcommerceFlow: View {
    
    @State private var selectedTab = EcommerceFlowTabItem.home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Favorites")
                .tabItem { tabItemLabel(.favorites) }
                .tag(EcommerceFlowTabItem.favorites)
            Text("Home")
                .tabItem { tabItemLabel(.home) }
                .tag(EcommerceFlowTabItem.home)
            Text("Profile")
                .tabItem { tabItemLabel(.profile) }
                .tag(EcommerceFlowTabItem.profile)
        }
        .accentColor(.orange)
    }
}

// MARK: Tab Related Extension
extension EcommerceFlow {
    
    private func tabItemLabel(_ tab: EcommerceFlowTabItem) -> some View {
        Label(tab.title, systemImage: tab.systemImage)
    }
}

struct EcommerceFlow_Previews: PreviewProvider {
    static var previews: some View {
        EcommerceFlow()
            .preferredColorScheme(.dark)
    }
}

fileprivate enum EcommerceFlowTabItem {
    case home, favorites, profile
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .favorites: return "Favorites"
        case .profile: return "Profile"
        }
    }
    
    var systemImage: String {
        switch self {
        case .home: return "house"
        case .favorites: return "heart"
        case .profile: return "person"
        }
    }
}
