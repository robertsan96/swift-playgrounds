//
//  SwiftUIActorsRaceCondition.swift
//  bootcamp-swiftui
//
//  Created by Robert Sandru on 10.11.2022.
//

import SwiftUI

struct SwiftUIActorsRaceCondition: View {
    
    @StateObject fileprivate var viewModel = SwiftUIActorsRaceConditionViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("Server: **\(viewModel.serverUrl)**")
            }
            HStack {
                Text("API Hits: **\(viewModel.apiHits)**")
            }
            Button("Start Tasks") {
                viewModel.startTasks()
            }
        }
    }
}

// Adding a view model layer
@MainActor // we're updating the main thread via the @Published properties
fileprivate class SwiftUIActorsRaceConditionViewModel: ObservableObject {
    
    @Published var serverUrl = ""
    @Published var apiHits: Int = 0
    
    private let remoteService = RemoteService()
    private var firstRemoteServiceTask: Task<Any, Never>?
    private var secondRemoteServiceTask: Task<Any, Never>?
    
    init() {
        serverUrl = remoteService.serverUrl // safe to do so
    }
    
    // This method is producing a race condition
    // However, it is not resulting in an exception
    // due to the safe nature of actors. Anyway,
    // on button press, notice the task priorities,
    // the printed value and the Text value on screen.
    func startTasks() {
        // will try to increase the number of api hits
        firstRemoteServiceTask = Task(priority: .low) {
            await self.remoteService.advancedApiCall()
        }
        
        // will try to show the correct number of api hits
        secondRemoteServiceTask = Task(priority: .userInitiated) {
            self.apiHits = await self.remoteService.apiHits
        }
    }
}

fileprivate actor RemoteService {
    
    // Even though constants are nonisolated by default,
    // we gotta mark them with the "nonisolated" keyword
    // in order to be able to use them from the view context as
    // Xcode throws an error, weird? :D Maybe too less experience yet.
    nonisolated let serverUrl = "https://www.google.com"
    
    // Wrapping the api hits behing a setter in order to print
    // out the real value of the hits whenever it's set
    var apiHits: Int {
        set {
            _apiHits = newValue
            print("Actor: setting \(newValue)")
        }
        get { _apiHits }
    }
    private var _apiHits: Int = 0 // isolated, source of truth.
    
    func advancedApiCall() {
        // complicated logic here
        apiHits += 1
    }
}

struct SwiftUIActorsRaceCondition_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIActorsRaceCondition()
    }
}
