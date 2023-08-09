//
//  BounceAnimation.swift
//  Guide
//
//  Created by Shivam Rawat on 09/08/23.
//

import SwiftUI

struct BounceAnimation : AnimatableModifier {
    var numberOfJumps : CGFloat = 0 ;
    var amplitude  : CGFloat = 40 ;
    
    
    var animatableData: CGFloat {
        get {
            numberOfJumps
        }
        set {
            numberOfJumps = newValue
        }
    }
    
    func body(content : Content)  -> some View {
        return content
            .offset(x: 0 , y: -abs(sin(.pi * numberOfJumps)) * amplitude)
    }
}

extension View {
     func bounce(taps : CGFloat) -> some View {
         modifier(BounceAnimation(numberOfJumps: taps))
    }
}

struct BounceAnimationView: View {
    @State var taps : CGFloat = 0;
    var body: some View {
        Button {
           taps += 1
        } label: {
            Circle()
                .fill(.red)
                .frame(width: 30, height: 30)
                .bounce(taps: taps)
                .animation(.linear(duration: 2), value: taps)
        }
    }
}

#Preview {
    BounceAnimationView()
}
