//
//  SwiftStateObject.swift
//  bootcamp-swiftui
//
//  Created by Robert Sandru on 08.11.2022.
//

import SwiftUI

struct SwiftUIStateObject: View {
    
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
    
    // 5. Proving that the view is going to be asked to redraw
    // As this is not a @State variable, it is going to be recreated
    // whenever the view is redrawn
    var impalerRefreshRef = Int.random(in: 1000...10000)
    
    // 6. It is going to maintain the instance whenever parent redraws
    @StateObject var impalerViewModel = ImpalerViewModel()
    
    var body: some View {
        VStack {
            Text("Impaler Refresh Ref: \(impalerRefreshRef)")
            // 7. On redraw, the impaler number is not going to change, because the
            // the random number is not changing due to the lack of deinitialization
            Text("Impaler: \(impalerViewModel.impaler)")
            
            // 8. Number of impaled is going to be persisted even if a redraw is required (keeping the instance in memory as state)
            Text("Impaled: \(impalerViewModel.impaled)")
            
            // 9. Increasing the number will be maintained
            Button("Impale 'em!", action: { impalerViewModel.increment(impaledBy: .random(in: 1...5)) })
        }
        .onAppear {
            print("Redraw Signal!")
        }
    }
}

fileprivate class ImpalerViewModel: ObservableObject {
    
    @Published var impaler = "Vlad Tepes the \(Int.random(in: 4...100))th"
    @Published var impaled = 0
    
    // 9. Deinit is not getting called on every redraw
    deinit {
        print("Deinit called.")
    }
    
    func increment(impaledBy number: Int) {
        impaled += number
    }
}
struct SwiftUIStateObject_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIStateObject()
    }
}
