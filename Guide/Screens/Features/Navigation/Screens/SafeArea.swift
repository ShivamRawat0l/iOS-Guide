//
//  SafeArea.swift
//  Guide
//
//  Created by Shivam Rawat on 11/08/23.
//

import SwiftUI

struct SafeArea: View {
    var body: some View {
        NavigationView {
            VStack {
              Text("WORKING")
                Spacer()
            }
            
            .ignoresSafeArea(.all)
            .background(.blue)
        }
    }
}
#Preview {
    SafeArea()
}
