//
//  BlueView.swift
//  Guide
//
//  Created by Shivam Rawat on 10/08/23.
//

import SwiftUI

struct BlueView: View {
    init() {

        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 40)! ]
    }
    var body: some View {
        VStack {
            Circle()
                .fill(.blue)
                .navigationTitle(Text("Blue View").font(.system(size: 30.0)))
                .navigationBarTitleDisplayMode(.automatic)
                
        }.tint(.indigo)
    }
}

#Preview {
    BlueView()
}
