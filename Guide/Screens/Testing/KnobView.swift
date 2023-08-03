//
//  KnobView.swift
//  Guide
//
//  Created by Shivam Rawat on 03/08/23.
//

import SwiftUI

struct Knob : View {
    @Binding var value :Double ;
    var body : some View {
        RoundedRectangle(cornerRadius: 25.0)
            .fill(.red)
            .rotationEffect(Angle(degrees: value))
            .onTapGesture {
                value = 0;
            }
    }
}

struct KnobView: View {
    @State var angle : Double;
    var body: some View {
        Knob(value: $angle)
        Slider(value: $angle, in: 0 ... 360, step: 1.0, label: {
            Text("Slider")
        }  )
    }
}

#Preview {
    KnobView(angle: 0)
}
