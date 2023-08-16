//
//  OrangeView.swift
//  Guide
//
//  Created by Shivam Rawat on 11/08/23.
//

import SwiftUI

struct OrangeView: View {
    
    init () {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Georgia", size: 40.0)!]
    }
    var body: some View {
        VStack {
            Circle()
                .fill(.orange)
                
                .navigationTitle(Text("Orange View").font(.system(size: 20.0)))
                .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    OrangeView()
}
