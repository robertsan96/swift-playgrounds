//
//  BootcampTabView.swift
//  bootcamp-swiftui
//
//  Created by Robert Sandru on 08.11.2022.
//

import SwiftUI

struct BootcampTabViewOne: View {
    
    var cornerRadius: CGFloat = 10
    var height: CGFloat = 60
    
    var tabBackgroundColor: Color = .white
    
    var activeIndicatorHeight: CGFloat = 30
    var activeIndicatorWidth: CGFloat = 40
    var activeColor: Color = .yellow
    var activeTabBackgroundColor: Color = .white
    
    @Binding var activeTab: Int
    
    var tabs: [TabViewElement] = [
        .init(id: UUID(),
              title: "Home",
              systemImage: "house",
              activeSystemImage: "house.fill"),
        .init(id: UUID(),
              title: "Profile",
              systemImage: "person",
              activeSystemImage: "person.fill"),
        .init(id: UUID(),
              title: "Favorites",
              systemImage: "heart",
              backgroundColor: Color.white.cgColor,
              iconColor: Color.black.cgColor,
              textColor: Color.black.cgColor,
              activeSystemImage: "heart.fill",
              activeBackgroundColor: Color.white.cgColor,
              activeIconColor: Color.red.cgColor,
              activeTextColor: Color.red.cgColor)
    ]
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                activeIndicator(in: proxy.size)
                HStack(spacing: 0) {
                    ForEach(0..<tabs.count, id:\.self) { index in
                        TabViewElementView(isActive: activeTab == index,
                                           tabViewElement: tabs[index])
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(getTabBackgroundColor(for: tabs[index], active: activeTab == index))
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.2)) {
                                    activeTab = index
                                }
                            }
                    }
                }
                .frame(height: height)
                .frame(maxWidth: .infinity)
                .cornerRadius(cornerRadius)
                .shadow(color: .black.opacity(0.05), radius: 2, y: 5)
            }
        }
    }
    
    private func getTabBackgroundColor(for tab: TabViewElement, active: Bool = false) -> Color {
        if active {
            return (tab.activeBackgroundColor != nil) ? Color(tab.activeBackgroundColor!) : activeTabBackgroundColor
        } else {
            return (tab.backgroundColor != nil) ? Color(tab.backgroundColor!) : tabBackgroundColor
        }
    }
    
    private func activeIndicator(in size: CGSize) -> some View {
        Rectangle()
            .frame(height: activeIndicatorHeight)
            .frame(maxWidth: .infinity)
            .foregroundColor(.clear)
            .overlay {
                Rectangle()
                    .foregroundColor(activeColor)
                    .cornerRadius(cornerRadius)
                    .frame(width: activeIndicatorWidth)
                    .position(activeIndicatorPoint(in: size))
            }
    }

    private func activeIndicatorPoint(in size: CGSize) -> CGPoint {
        let tabWidth = size.width / CGFloat(tabs.count)
        let midTabSelectedTab = tabWidth * CGFloat(activeTab) + tabWidth / 2
        let xPos: CGFloat = midTabSelectedTab
        let yPos: CGFloat = activeIndicatorHeight+activeIndicatorHeight / 3
        return .init(x: xPos, y: yPos)
    }
}

fileprivate struct TabViewElementView: View {
    
    var isActive = false
    var tabViewElement: TabViewElement
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Image(systemName: isActive ? tabViewElement.activeSystemImage : tabViewElement.systemImage)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(getIconColor())
            }
            Text(tabViewElement.title)
                .font(.subheadline)
                .foregroundColor(getTextColor())
        }
    }
    
    private func getIconColor() -> Color {
        if isActive {
            return (tabViewElement.activeIconColor != nil) ? Color(cgColor: tabViewElement.activeIconColor!) : .black
        } else {
            return (tabViewElement.iconColor != nil) ? Color(cgColor: tabViewElement.iconColor!) : .black
        }
    }
    
    private func getTextColor() -> Color {
        if isActive {
            return (tabViewElement.activeTextColor != nil) ? Color(cgColor: tabViewElement.activeTextColor!) : .black
        } else {
            return (tabViewElement.textColor != nil) ? Color(cgColor: tabViewElement.textColor!) : .black
        }
    }
}

struct TabViewElement: Identifiable {
    
    let id: UUID
    let title: String
    let systemImage: String
    
    var backgroundColor: CGColor? = nil
    var iconColor: CGColor? = nil
    var textColor: CGColor? = nil
    
    let activeSystemImage: String
    var activeBackgroundColor: CGColor? = nil
    var activeIconColor: CGColor? = nil
    var activeTextColor: CGColor? = nil
}

struct BootcampTabViewOneWrapper: View {
    
    @State var activeTab = 2
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea(.all)
                .foregroundColor(Color.cyan.opacity(0.08))
            
            BootcampTabViewOne(activeTab: $activeTab)
                .padding()
            
            Button("Change Active") {
                withAnimation {
                    activeTab = Int.random(in: 0...3)
                }
            }
        }
    }
}

struct BootcampTabViewOne_Previews: PreviewProvider {
    
    static var previews: some View {
        BootcampTabViewOneWrapper()
    }
}
