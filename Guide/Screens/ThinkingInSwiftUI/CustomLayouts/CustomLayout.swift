//
//  CustomLayout.swift
//  Guide
//
//  Created by Shivam Rawat on 07/08/23.
//

import SwiftUI

struct WidthKey : PreferenceKey {
    static  let defaultValue: CGFloat = 0 ;
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        print(value , nextValue() ,"HEERE")
        if value < 10 {
            value = nextValue()
        }
    }
}

struct ButtonText : View {
    @State var width : CGFloat? = nil;
    var body : some View  {
        Text("Start")
            .foregroundColor(.white)
            .padding(10)
            .background(
                GeometryReader { proxy in
                    Color.clear.preference(key: WidthKey.self, value: proxy.size.width)
                }
            )
            .onPreferenceChange(WidthKey.self, perform: { value in
                width = value;
            })
            .frame(width: width,height: width)
            .background(
                    Circle()
                        .fill(Color.blue)
                        .frame(width: width,
                               height: width)
            )
    }
}
struct CustomLayout: View {
    var body: some View {
        VStack {
            ButtonText()
            ButtonText()
            ButtonText()
        }
    }
}

#Preview {
    CustomLayout()
}
