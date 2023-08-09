//
//  AnimationView.swift
//  Guide
//
//  Created by Shivam Rawat on 08/08/23.
//

import SwiftUI

struct AnimationView: View {
    @State var state : Bool = false ;
    @Namespace var ns;
    @State var loading : Bool = false;
    var body: some View{
        VStack {
            Image(systemName: "steeringwheel")
                .rotationEffect(Angle(degrees: loading  ? 0 : 360 ), anchor: .center)
                //.animation(.default.repeatForever(autoreverses: false))
                .onAppear{
                    withAnimation(.linear.repeatForever(autoreverses: false)) {
                        loading = true;
                    }
                }
            HStack {
                if !state {
                    Rectangle().fill(.blue)
                        .matchedGeometryEffect(id: "1", in: ns)
                    .frame(width: 200, height: 200)
                }
                Spacer()
                if state {
                    Circle().fill(.blue) .matchedGeometryEffect(id: "1", in: ns)
                        .frame(width: 100, height: 100)
                        .transition(.slide)
                        //.animation(.bouncy)
                }
            }
            .border(Color.black) .frame(width: 300, height: 200)
            Toggle("", isOn: $state)
        }
      //  .animation(.bouncy)
    }
}

#Preview {
    AnimationView()
}
