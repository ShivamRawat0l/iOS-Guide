//
//  NavigationController.swift
//  Guide
//
//  Created by Shivam Rawat on 10/08/23.
//

import SwiftUI

struct NavigationController: View {
    var body: some View {
        NavigationView {
            VStack{
                Circle()
                    .fill(.red)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Red One")
                
                NavigationLink(destination: GreenView(), label: {
                    Text("Navigate to the green screen")
                })
                NavigationLink(destination: BlueView(), label: {
                    Text("Navigate to the blue screen")
                })
                NavigationLink(destination: OrangeView(), label: {
                    Text("Navigate to the orangeGeorge George screen")
                })
            }
        }.tint(.green)
    }
}

#Preview {
    NavigationController()
}
