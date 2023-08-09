//
//  CustomLayout.swift
//  Guide
//
//  Created by Shivam Rawat on 07/08/23.
//

import SwiftUI

struct Bounds : PreferenceKey {
    static var defaultValue : Anchor<CGRect>? = nil ;
    static func reduce(value: inout Anchor<CGRect>?, nextValue: () -> Anchor<CGRect>?) {
        value = value ?? nextValue();
    }
}

struct AnchorView : View {
    
    let texts : [Text] = [
        Text("Hello"),
        Text("How are you "),
        Text("World")
    ]
    @State var selectedIndex : Int = 0 ;
    @Namespace var ns;
    var body : some View  {
        
        HStack{
            ForEach(texts.indices) { index in
                Button {
                    withAnimation(.bouncy) {
                        selectedIndex = index;
                    }
                } label: {
                    texts[index]
                        .matchedGeometryEffect(id: index, in: ns)
                }
            }
                .overlay(
                            Rectangle()
                                .fill(Color.accentColor)
                                .frame(height: 2)
                                .matchedGeometryEffect(id: selectedIndex, in: ns,isSource: false)
                    )
        }
        Spacer()
        HStack{
            ForEach(texts.indices) { index in
                Button {
                    withAnimation(.bouncy) {
                        selectedIndex = index;
                    }
                } label: {
                    texts[index]
                        .anchorPreference(key:Bounds.self,value: .bounds, transform: { anchor in
                            if index == selectedIndex {
                                return anchor
                            }
                            return nil;
                        })
                }
                .overlayPreferenceValue(Bounds.self, { anchor in
                    GeometryReader { proxy in
                        if let anchor {
                            Rectangle()
                                .fill(Color.accentColor)
                                .frame(width: proxy[anchor].width ?? 200,height: 2)
                                .offset(x: proxy[anchor].minX ?? 0)
                        }
                    }
                })
            }
        }
    }
}
#Preview {
    AnchorView()
}
