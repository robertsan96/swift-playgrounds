//
//  SwiftUIActors.swift
//  bootcamp-swiftui
//
//  Created by Robert Sandru on 09.11.2022.
//
//  Based on https://www.avanderlee.com/swift/actors/
//

import SwiftUI

struct SwiftUIActors: View {
    
    fileprivate var feeder = ChickenFeeder()
    
    var body: some View {
        VStack {
            Text("Actors are amazing.")
        }
        .onAppear {
            print(feeder.description)
            feeder.printChickenFood() // safe to call, marked with nonisolated.
            // feeder.printChickenFoodIsolatedMethod() // can only be called in a async context
        }
        .task {
            // we can call the isolated method from here as the .task modifier
            // is providing an async context with a lifetime that matches that of the
            // modified view. We should be safe here!
            await feeder.printChickenFoodIsolatedMethod()
        }
    }
}

// Reference type, but you can't use inheritance with actors.
fileprivate actor ChickenFeeder {
    
    let food = "worms" // immutable => non-isolated property. Safe to use, does not cause data races.
    var chickensEating = 0 // mutable, isolated property. Could introduce data races, but that's why we're using actor.
}

extension ChickenFeeder {
    
    // Telling the compiler that this method is nonisolated,
    // as we are not accessing any isolated data.
    // However, we could print the food property
    // from outside the instance in a sync context, as it is immutable.
    // Swift is locking mutable properties of actors to prevent data races.
    // This could be called from a sync context.
    nonisolated func printChickenFood() {
        print("Chickens are eating \(food)")
    }
    
    // This can't be called outside an async context
    func printChickenFoodIsolatedMethod() {
        print("You can't access this method in a sync context, as this function is isolated. Anyway, we can reach the eating chickens in a sync maneer: \(chickensEating)!")
    }
    
    // We can use the nonisolated keyword on computed properties too
    nonisolated var description: String {
        "Chickens eating: \(food)"
    }
}

struct SwiftUIActors_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIActors()
    }
}
