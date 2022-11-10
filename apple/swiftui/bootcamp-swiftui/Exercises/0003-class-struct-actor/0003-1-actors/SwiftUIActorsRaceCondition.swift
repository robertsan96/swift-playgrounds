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
    
    deinit {
        print("Deinit...")
        firstRemoteServiceTask?.cancel()
        secondRemoteServiceTask?.cancel()
    }
    
    // This method is producing a race condition
    // However, it is not resulting in an exception
    // due to the safe nature of actors. Anyway,
    // on button press, notice the task priorities,
    // the printed value and the Text value on screen.
    //
    // If the sleepTime of this task is smaller than the seconds,
    // we are NOT going to encounter the race condition:
    // advancedApiCall will increase the apiHits counter
    // the secondRemoteServiceTask is trying to set it in the
    // publisher. Normal flow.
    // Otherwise, if it takes longer to call the advancedApiCall,
    // the shown number of hits on the screen will be smaller
    // than the real number set in remoteService.apiHits !
    func startTasks() {
        // will try to increase the number of api hits
        let firstSleepTime = TimeInterval.random(in: 2...5)
        let secondSleepTime = TimeInterval.random(in: 2...5)
        
        firstRemoteServiceTask?.cancel()
        secondRemoteServiceTask?.cancel()
        
        firstRemoteServiceTask = Task { [weak self] in
            print("FirstRemoteService sleeping for: \(firstSleepTime)")
            
            // in order to avoid delayed deinitialization, the task is cancelled manually
            // so we can't force the try, because the task could throw a CancellationError
            // on cancellation, we don't want to call the api in the actor.
            // smash that Start Tasks button to see.
            do {
                try await Task.sleep(for: .seconds(firstSleepTime))
                await self?.remoteService.advancedApiCall()
            } catch {
                print("FirstRemoteService cancelled - not increasing hits.")
            }
            return
        }
        
        // will try to show the correct number of api hits
        secondRemoteServiceTask = Task { [weak self] in
            print("SecondRemoteService sleeping for: \(secondSleepTime)")
            do {
                try await Task.sleep(for: .seconds(secondSleepTime))
                if let apiHits = await self?.remoteService.apiHits {
                    self?.apiHits = apiHits
                    print("SecondRemoteService set api hits to: \(apiHits)")
                }
            } catch {
                print("SecondRemoteService cancelled - not updating hits")
            }
            return
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
