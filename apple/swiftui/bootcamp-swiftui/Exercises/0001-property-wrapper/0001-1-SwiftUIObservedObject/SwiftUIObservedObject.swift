//
//  SwiftObservedObject.swift
//  bootcamp-swiftui
//
//  Created by Robert Sandru on 08.11.2022.
//

import SwiftUI

struct SwiftUIObservedObject: View {
    
    // 1. Refresh Signal - the view is going to redraw on state change
    @State var refreshRef = Int.random(in: 1...100)
    
    var body: some View {
        VStack {
            // 2. Current Refresh Number (random)
            Text("Refresh Ref: \(refreshRef)")
            
            // 3. Children View is going to be redrawn on refresh signal
            ImpalerCardView()
                .padding()
                .background(Color.gray.opacity(0.2))
            
            // 4. Refresh Signal Trigger
            Button("Refresh Ref!", action: { refreshRef = Int.random(in: 1...100) })
        }
    }
}

fileprivate struct ImpalerCardView: View {
    
    // 5. It is going to create a new instance whenever parent redraws
    @ObservedObject var impalerViewModel = ImpalerViewModel()
    
    var body: some View {
        VStack {
            // 6. On redraw, the impaler number changes as it is randomly generated in the view model
            Text("Impaler: \(impalerViewModel.impaler)")
            
            // 7. Number of impaled is going to be 0 whenever a redraw is required
            Text("Impaled: \(impalerViewModel.impaled)")
            
            // 8. Increasing the number will be maintained until parent asks for redraw
            Button("Impale 'em!", action: { impalerViewModel.increment(impaledBy: .random(in: 1...5)) })
        }
    }
}

fileprivate class ImpalerViewModel: ObservableObject {
    
    @Published var impaler = "Vlad Tepes the \(Int.random(in: 4...100))th"
    @Published var impaled = 0
    
    // 9. Deinit is getting called on every redraw
    deinit {
        print("Deinit called.")
    }
    
    func increment(impaledBy number: Int) {
        impaled += number
    }
}

struct SwiftUIObservedObject_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIObservedObject()
    }
}
