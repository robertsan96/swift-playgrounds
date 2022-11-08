//
//  PassingViewModelToChildren.swift
//  bootcamp-swiftui
//
//  Created by Robert Sandru on 08.11.2022.
//

import SwiftUI

struct PassingViewModelToChildren: View {
    
    var body: some View {
        ImpalerView()
    }
}

fileprivate struct ImpalerView: View {
    
    @State var refreshRef = Int.random(in: 1...5000)
    @State var impalers: [Impaler] = []
    
    @State var showEditView: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                Text("Refresh Ref: \(refreshRef)")
                LazyVStack {
                    ForEach(impalers) { impaler in
                        ImpalerCardView(viewModel: ImpalerCardViewModel(impaler: impaler))
                    }
                }
                .padding()
            }
            
            if impalers.count > 0 {
                ImpalerEditView(impaler: $impalers[0], showEditView: $showEditView)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                trailingActions()
            }
            ToolbarItem(placement: .navigationBarLeading) {
                leadingActions()
            }
            ToolbarItem(placement: .principal) {
                principalActions()
            }
        }
    }
    
    private func trailingActions() -> some View {
        Button {
            impalers.append(.init(id: UUID(),
                                  name: "Vlad Tepes the \(Int.random(in: 4...100))th",
                                  impaled: 0))
        } label: {
            Image(systemName: "plus")
        }
    }
    
    private func leadingActions() -> some View {
        HStack {
            Button {
                impalers = []
            } label: {
                Image(systemName: "trash")
            }
            
            Button {
                showEditView.toggle()
            } label: {
                Image(systemName: "pencil")
            }
        }
    }
    
    private func principalActions() -> some View {
        HStack {
            Button {
                refreshRef = Int.random(in: 1...5000)
            } label: {
                Image(systemName: "arrow.counterclockwise")
            }
        }
    }
}

fileprivate struct ImpalerCardView: View {
    
    var refreshRef = Int.random(in: 1...50)
    @ObservedObject var viewModel: ImpalerCardViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("**\(viewModel.impaler.name)**")
                Spacer()
                Text("Impaled: **\(viewModel.impaler.impaled)**")
            }
            HStack {
                Text("Refresh Ref: \(refreshRef)")
                Spacer()
            }
        }
        .padding(10)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(15)
    }
}

fileprivate class ImpalerCardViewModel: ObservableObject {
    @Published var impaler: Impaler
    
    // Going to be called each time the parent view asks for redraw (press the refresh button)
    init(impaler: Impaler) {
        self.impaler = impaler
    }
    
    // On ImpalerView state change, the whole list is going to be redrawn
    // This means, list items are going to receive a new view model because
    // of the @ObservedObject property wrapper. The old view models are going to be
    // deallocated.
    deinit {
        print("Deinit \(impaler.name)")
    }
}

fileprivate struct Impaler: Identifiable {
    
    let id: UUID
    let name: String
    var impaled: Int
}

fileprivate struct ImpalerEditView: View {
    
    @Binding var impaler: Impaler
    @Binding var showEditView: Bool
    
    var body: some View {
        if showEditView {
            VStack {
                Spacer()
                VStack {
                    HStack {
                        Text(impaler.name)
                        Spacer()
                        Button("Increase Impaled") { impaler.impaled += 1 }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
            }
            .frame(maxWidth: .infinity)
            .background(Color.black.opacity(0.2))
            .onTapGesture {
                showEditView.toggle()
            }
        } else {
            EmptyView()
        }
    }
}

struct PassingViewModelToChildren_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PassingViewModelToChildren()
        }
    }
}
