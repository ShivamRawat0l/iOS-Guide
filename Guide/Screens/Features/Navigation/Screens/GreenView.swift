//
//  GreenView.swift
//  Guide
//
//  Created by Shivam Rawat on 10/08/23.
//

import SwiftUI

struct GreenView: View {
    init() {

        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 8)! ]
    }
    var body: some View {
        VStack {
            Circle()
                .fill(.green)
                
                .navigationTitle(Text("Green View").font(.system(size: 20.0)))
                .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    GreenView()
}
