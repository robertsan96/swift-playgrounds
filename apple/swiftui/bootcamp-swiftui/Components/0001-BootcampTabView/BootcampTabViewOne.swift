//
//  BootcampTabView.swift
//  bootcamp-swiftui
//
//  Created by Robert Sandru on 08.11.2022.
//

import SwiftUI

struct BootcampTabViewOne: View {
    
    var cornerRadius: CGFloat = 10
    
    var defaultTabBackgroundColor: Color = .white
    var defaultActiveTabBackgroundColor: Color = .white
    
    @Binding var activeTab: Int

    private(set) var activeIndicatorHeight: CGFloat = 15
    private(set) var activeIndicatorWidth: CGFloat = 40
    
    var tabs: [TabViewElement] = [
        .init(id: UUID(),
              title: "Profile",
              systemImage: "person",
              activeSystemImage: "person.fill"),
        .init(id: UUID(),
              title: "Home",
              systemImage: "house",
              activeSystemImage: "house.fill",
              backgroundColor: CGColor(red: 255, green: 255, blue: 255, alpha: 1),
              iconColor: CGColor(red: 0, green: 0, blue: 0, alpha: 1),
              textColor: CGColor(red: 0, green: 0, blue: 0, alpha: 1),
              activeIconColor: CGColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1),
              activeTextColor: CGColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1)),
        .init(id: UUID(),
              title: "Favorites",
              systemImage: "heart",
              activeSystemImage: "heart.fill",
              backgroundColor: CGColor(red: 255, green: 255, blue: 255, alpha: 1),
              iconColor: CGColor(red: 0, green: 0, blue: 0, alpha: 1),
              textColor: CGColor(red: 0, green: 0, blue: 0, alpha: 1),
              activeBackgroundColor: CGColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1),
              activeIconColor: CGColor(red: 255, green: 255, blue: 255, alpha: 1),
              activeTextColor: CGColor(red: 255, green: 255, blue: 255, alpha: 1))
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
                .frame(height: proxy.size.height - activeIndicatorHeight / 2)
                .cornerRadius(cornerRadius)
                .shadow(color: .black.opacity(0.05), radius: 2, y: 5)
            }
        }
    }
    
    private func getTabBackgroundColor(for tab: TabViewElement, active: Bool = false) -> Color {
        if active {
            return (tab.activeBackgroundColor != nil) ? Color(cgColor: tab.activeBackgroundColor!) : defaultActiveTabBackgroundColor
        } else {
            return (tab.backgroundColor != nil) ? Color(cgColor: tab.backgroundColor!) : defaultTabBackgroundColor
        }
    }
    
    private func activeIndicator(in size: CGSize) -> some View {
        Rectangle()
            .frame(height: activeIndicatorHeight / 2)
            .frame(maxWidth: .infinity)
            .foregroundColor(.clear)
            .overlay {
                Rectangle()
                    .foregroundColor(getTabBackgroundColor(for: tabs[activeTab], active: true))
                    .cornerRadius(cornerRadius)
                    .frame(width: activeIndicatorWidth)
                    .position(activeIndicatorPoint(in: size))
            }
    }

    private func activeIndicatorPoint(in size: CGSize) -> CGPoint {
        let tabWidth = size.width / CGFloat(tabs.count)
        let midTabSelectedTab = tabWidth * CGFloat(activeTab) + tabWidth / 2
        let xPos: CGFloat = midTabSelectedTab
        let yPos: CGFloat = activeIndicatorHeight - activeIndicatorHeight / 2
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
                    .font(.footnote)
                    .foregroundColor(getIconColor())
                    .scaleEffect(isActive ? 1.5 : 1)
            }
            Text(tabViewElement.title)
                .font(.footnote)
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
    let activeSystemImage: String
    
    var backgroundColor: CGColor? = nil
    var iconColor: CGColor? = nil
    var textColor: CGColor? = nil
    
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
                .foregroundColor(Color.cyan.opacity(0.15))
            
            VStack {
                BootcampTabViewOne(activeTab: $activeTab)
                    .frame(height: 60)
                    .padding()
            }
        }
    }
}

struct BootcampTabViewOne_Previews: PreviewProvider {
    
    static var previews: some View {
        BootcampTabViewOneWrapper()
    }
}
