//
//  CounterScreen.swift
//  Guide
//
//  Created by Shivam Rawat on 03/08/23.
//

import SwiftUI

struct CounterScreen: View {
    @State var counter : Int = 0 ;
    var body: some View {
        VStack{
            HStack(spacing: 0) {
                Rectangle()
            .fill(Color.red)
            .frame(minWidth: 50)
                Rectangle()
            .fill(Color.blue) .frame(maxWidth: 100) .layoutPriority(1)
            }.frame(width: 75)
            Button {
                counter += 1;
            } label: {
                Text("Tap Me")
                    .padding()
                    .background(.tertiary)
                    .cornerRadius(9.0)
            }
            Text("You have tapped \(counter) times")
        }
        .border(.black)
        .debug()
    }
}
extension View {
    func debug() -> Self {
        print(Mirror(reflecting:  self).subjectType)
        return self
    }
}
#Preview {
    CounterScreen()
}
