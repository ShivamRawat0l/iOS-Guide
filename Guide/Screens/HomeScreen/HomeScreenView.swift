//
//  HomeScreenView.swift
//  Guide
//
//  Created by Shivam Rawat on 05/07/23.
//

import SwiftUI

struct HomeScreenView: View {
    var body: some View {
        LazyVGrid(columns: [GridItem(),GridItem()], content: {
            NavigationLink {
                PairGameView()
            } label: {
                VStack(content: {
                    Text("Match Cards")
                    Text("Puzzle Game")
                })
                .background(Color.red)
            }
            .buttonStyle(PlainButtonStyle())
        })
    }
}

struct HomeScreenView_Preview : PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
