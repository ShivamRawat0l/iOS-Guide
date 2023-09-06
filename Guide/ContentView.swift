//
//  ContentView.swift
//  Guide
//
//  Created by Shivam Rawat on 20/06/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboardingComplete") var onboardingComplete = false;
    let store = FlickerStore()
    var body: some View {
        
        NavigationView{
            //  FlickerImageRedux()
            //     .environmentObject(store)
            FlickerImage()
            //  BumbleAnimation()
            // NavigationController()
            // KeyboardAware()
            // LineAnimation()
            //   AnimationModifier()
            //   AnimationView()
            // TableView()
            //  CustomStack()
            //   CustomLayout()
            //        KnobView(angle: 0.0)
            //ImageListView()
            //   ChatScreenView()
            //HomeScreenView()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

