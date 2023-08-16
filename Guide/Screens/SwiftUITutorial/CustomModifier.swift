//
//  CustomModifier.swift
//  Guide
//
//  Created by Shivam Rawat on 10/08/23.
//

import SwiftUI

struct CustomBlue : ViewModifier {
    func body(content : Content) -> some View {
        content.background(.blue)
    }
}

struct CustomGreen: ViewModifier {
    func body(content : Content) -> some View {
        content.background(.green)
    }
}

extension View {
    func backgroundRed() -> some View {
        self.background(.red)
    }
    func backgroundBlue() -> some View {
        modifier(CustomBlue())
    }
    func backgroundGreen() -> some View {
        ModifiedContent(content: self, modifier: CustomGreen())
    }
}

struct CustomModifier: View {
    var body: some View {
        VStack {
           Text("ONE")
                .backgroundRed()
           Text("ONE")
                .backgroundGreen()
           Text("ONE")
                .backgroundBlue()
        }
    }
}

#Preview {
    CustomModifier()
}
