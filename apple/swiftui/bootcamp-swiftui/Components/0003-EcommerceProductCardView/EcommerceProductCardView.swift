//
//  EcommerceProductCardView.swift
//  bootcamp-swiftui
//
//  Created by Robert Sandru on 09.11.2022.
//

import SwiftUI

struct EcommerceProductCardView: View {
    
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
        }
    }
}

// MARK: Previews

#if DEBUG
struct EcommerceProductCardViewPreviewWrapper: View {
    
    var body: some View {
        EcommerceProductCardView(title: "Pear Book Pro 18 (2021) with Pear P1 Pro, 10 CPU cores, 16 GPU cores, 16GB, 1TB SSD, Pear Grey, Int KB")
    }
}

struct EcommerceProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        EcommerceProductCardViewPreviewWrapper()
    }
}
#endif
