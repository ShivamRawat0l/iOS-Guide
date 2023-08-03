//
//  LabelView.swift
//  Guide
//
//  Created by Shivam Rawat on 03/08/23.
//

import SwiftUI
struct LabelView: View {
    @Binding var counter: Int
    @ViewBuilder var helper: some View {
   
            if counter > 0 {
                Text("You've tapped \(counter) times")
            }
        
    }
    var body : some View {
        helper
    }
}

#Preview {
    LabelView(counter: .constant(1))
}
