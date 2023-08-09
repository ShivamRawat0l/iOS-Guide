//
//  AnimationModifier.swift
//  Guide
//
//  Created by Shivam Rawat on 09/08/23.
//

import SwiftUI

struct ShakeAnimation : AnimatableModifier  {
    
    var taps : CGFloat = 0 ;
    var amplitude : CGFloat = 10.0 ;
    var animatableData: CGFloat {
        get { taps }
        set { taps = newValue }
    }
    
    func body(content : Content) -> some View {
        content.offset(x: sin(.pi * 2.0 * taps) * amplitude)
    }
}

extension View {
    func shake(taps : CGFloat ) -> some View {
        return  ModifiedContent(content: self, modifier: ShakeAnimation(taps:taps))
        //modifier(ShakeAnimation(taps:taps))
    }
}

struct ShakeTransition : ViewModifier {
    var active : Bool ;
    
    func body(content: Content) -> some View {
        return  content.blur(radius: active ? 0 : 50).opacity(active ? 1 : 0)
    }
}

extension AnyTransition {
    static var newTransition : AnyTransition {
        .modifier(active: ShakeTransition(active: false), identity: ShakeTransition(active: true))
    }
}


struct Blur: ViewModifier {
    var active: Bool
    func body(content: Content) -> some View {
        return content
            .blur(radius: active ? 50 : 0)
            .opacity(active ? 0 : 1)
    }
}


extension AnyTransition {
    static var blur: AnyTransition {
        .modifier(active: Blur(active: true), identity: Blur(active: false))
    }
}

struct AnimationModifier: View {
    @State var taps : CGFloat = 0 ;
    @State var visible : Bool = true;
    var body: some View {
        VStack {
            if visible {
                Circle()
                    .animation(.linear(duration: 1))
                    .transition(.blur)
            }
            if visible {
                Button {
                    taps = taps + 1
                } label: {
                    Text("Shake")
                        .background(.red)
                        .shake(taps: taps * 3)
                }
                
                
            }
            Toggle("TOggle", isOn: $visible)
        }
    }
}

#Preview {
    AnimationModifier()
}


