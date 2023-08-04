//
//  KnobView.swift
//  Guide
//
//  Created by Shivam Rawat on 03/08/23.
//

import SwiftUI

struct Knob : View {
    @Binding var value :Double ;
    @Environment(\.knobColor) var color : CGFloat;
    var body : some View {
        RoundedRectangle(cornerRadius: 25.0)
            .fill(.red)
            .saturation(color)
            .rotationEffect(Angle(degrees: value))
            .onTapGesture {
                value = 0;
            }
            .frame(height: 200)
    }
}

struct KnobView: View {
    @State var angle : Double;
    @State var isOn : Bool  = false;
    @State var color : CGFloat = 0;
    var body: some View {
        VStack{
            Knob(value: $angle)
                .setKnobColor(val: color)
            Text("Adls")
            Slider(value: $angle, in: 0 ... 360, step: 1.0, label: {
                Text("Slider")
            }  )
            Text("This ")
            Slider(value: $color, in: 0 ... 10.0, step: 1.0, label: {
                Text("Color")
            })
            Toggle("IS thsi working", isOn: $isOn)
        }
    }
}

fileprivate struct KnobColor : EnvironmentKey {
    static let defaultValue: CGFloat = 0.0;
}

extension EnvironmentValues {
    var knobColor : CGFloat {
        get {
            self[KnobColor.self]
        }
        set {
            self[KnobColor.self] = newValue
        }
    }
}

extension View {
    func setKnobColor(val : CGFloat) ->some View {
        environment(\.knobColor,val)
    }
}


#Preview {
    KnobView(angle: 0)
}
