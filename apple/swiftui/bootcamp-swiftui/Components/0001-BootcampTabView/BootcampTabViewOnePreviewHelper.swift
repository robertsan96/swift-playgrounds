//
//  BootcampTabViewOnePreviewHelper.swift
//  bootcamp-swiftui
//
//  Created by Robert Sandru on 09.11.2022.
//

import SwiftUI

struct BootcampTabViewOnePreviewHelper: View {
    
    @State private var availableTabColors: [Color] = [.red, .white, .green, .blue, .yellow]
    private(set) var cornerRadius: CGFloat = 15
    
    @Binding var tabs: [TabViewElement]
    @Binding var activeTab: Int
    
    @State private var selectedTabTextColor: Int = 0
    @State private var selectedTabIconColor: Int = 0
    @State private var selectedTabActiveTextColor: Int = 0
    @State private var selectedTabActiveIconColor: Int = 0
    @State private var selectedTabBackgroundColor: Int = 0
    @State private var selectedTabActiveBackgroundColor: Int = 0
    
    var body: some View {
        VStack {
            if tabs.count > 0, tabs.indices.contains(activeTab) {
                VStack {
                    headerView()
                    VStack {
                        tabTitleTextFieldView()
                        tabColorSwitcherView()
                    }
                    .padding()
                }
                .background(Color.white)
                .cornerRadius(cornerRadius)
            } else {
                Text("No tabs for preview helper.")
                addTabButton()
                    .padding()
            }
        }
        .padding()
    }

    private func headerView() -> some View {
        HStack {
            Text("Tab: \(activeTab + 1)")
                .font(.body)
                .fontWeight(.bold)
            Spacer()
            deleteTabButton(at: activeTab)
            addTabButton()
        }
        .padding()
        .background(Color.black.opacity(0.04))
    }
    
    private func tabTitleTextFieldView() -> some View {
        HStack {
            Text("Title:")
            TextField("", text: $tabs[activeTab].title)
        }
    }
    
    private func tabColorSwitcherView() -> some View {
        VStack {
            HStack {
                Text("Text Color: ")
                Spacer()
                BootcampColorSwitcherView(colors: availableTabColors, selectedIndex: $selectedTabTextColor)
                    .onChange(of: selectedTabTextColor) { newValue in
                        tabs[activeTab].textColor = UIColor(availableTabColors[newValue]).cgColor
                    }
            }
            HStack {
                Text("Icon Color: ")
                Spacer()
                BootcampColorSwitcherView(colors: availableTabColors, selectedIndex: $selectedTabIconColor)
                    .onChange(of: selectedTabIconColor) { newValue in
                        tabs[activeTab].iconColor = UIColor(availableTabColors[newValue]).cgColor
                    }
            }
            HStack {
                Text("Background Color: ")
                Spacer()
                BootcampColorSwitcherView(colors: availableTabColors, selectedIndex: $selectedTabBackgroundColor)
                    .onChange(of: selectedTabBackgroundColor) { newValue in
                        tabs[activeTab].backgroundColor = UIColor(availableTabColors[newValue]).cgColor
                    }
            }
            HStack {
                Text("**Active** Text Color: ")
                Spacer()
                BootcampColorSwitcherView(colors: availableTabColors, selectedIndex: $selectedTabActiveTextColor)
                    .onChange(of: selectedTabActiveTextColor) { newValue in
                        tabs[activeTab].activeTextColor = UIColor(availableTabColors[newValue]).cgColor
                    }
            }
            HStack {
                Text("**Active** Icon Color: ")
                Spacer()
                BootcampColorSwitcherView(colors: availableTabColors, selectedIndex: $selectedTabActiveIconColor)
                    .onChange(of: selectedTabActiveIconColor) { newValue in
                        tabs[activeTab].activeIconColor = UIColor(availableTabColors[newValue]).cgColor
                    }
            }
            HStack {
                Text("**Active** Background: ")
                Spacer()
                BootcampColorSwitcherView(colors: availableTabColors, selectedIndex: $selectedTabActiveBackgroundColor)
                    .onChange(of: selectedTabActiveBackgroundColor) { newValue in
                        tabs[activeTab].activeBackgroundColor = UIColor(availableTabColors[newValue]).cgColor
                    }
            }
        }
    }
    
    private func addTabButton() -> some View {
        Button {
            withAnimation {
                tabs.append(
                    .init(id: UUID(),
                          title: "Shop",
                          systemImage: "cart",
                          activeSystemImage: "cart.fill",
                          backgroundColor: CGColor(red: 255, green: 255, blue: 255, alpha: 1),
                          iconColor: CGColor(red: 0, green: 0, blue: 0, alpha: 1),
                          textColor: CGColor(red: 0, green: 0, blue: 0, alpha: 1),
                          activeBackgroundColor: CGColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1),
                          activeIconColor: CGColor(red: 255, green: 255, blue: 255, alpha: 1),
                          activeTextColor: CGColor(red: 255, green: 255, blue: 255, alpha: 1)
                ))
            }
        } label: {
            Image(systemName: "plus")
        }
    }
    
    private func deleteTabButton(at index: Int) -> some View {
        Button {
            if tabs.indices.contains(index) {
                activeTab = 0
                tabs.remove(at: index)
            }
        } label: {
            Image(systemName: "trash")
        }

    }
}
