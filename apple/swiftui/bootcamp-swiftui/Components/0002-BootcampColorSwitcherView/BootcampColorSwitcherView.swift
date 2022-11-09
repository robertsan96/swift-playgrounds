//
//  BootcampColorSwitcherView.swift
//  bootcamp-swiftui
//
//  Created by Robert Sandru on 09.11.2022.
//

import SwiftUI

struct BootcampColorSwitcherView: View {
    
    var colors: [Color] = []
    
    private(set) var circleWidth: CGFloat = 25
    private(set) var circleHeight: CGFloat = 25
    private(set) var notSelectedOpacity: CGFloat = 0.2
    
    @Binding var selectedIndex: Int
    
    var body: some View {
        HStack {
            ForEach(0..<colors.count, id:\.self) { color in
                colorCircle(color: colors[color], isSelected: color == selectedIndex)
                    .onTapGesture { handleCircleTap(at: color) }
            }
        }
    }
    
    private func handleCircleTap(at index: Int) {
        withAnimation(.linear(duration: 0.1)) {
           selectedIndex = index
       }
    }
    
    private func colorCircle(color: Color, isSelected: Bool) -> some View {
        Circle()
            .fill(isSelected ? color : color.opacity(notSelectedOpacity))
            .frame(width: circleWidth, height: circleHeight)
            .shadow(color: isSelected ? .black.opacity(0.2) : .clear, radius: 2, x: 0, y: 0)
    }
}

fileprivate struct BootcampColorSwitcherViewPreviewWrapper: View {
    
    @State private var selectedIndex = 0
    
    var body: some View {
        BootcampColorSwitcherView(colors: [.red, .blue, .green, .yellow, .cyan],
                                  selectedIndex: $selectedIndex)
    }
}

struct BootcampColorSwitcherView_Previews: PreviewProvider {
    static var previews: some View {
        BootcampColorSwitcherViewPreviewWrapper()
    }
}
