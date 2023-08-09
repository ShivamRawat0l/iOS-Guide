//
//  LayoutView.swift
//  Guide
//
//  Created by Shivam Rawat on 07/08/23.
//

import SwiftUI

struct LayoutView: View {
    var body: some View {
        Text("Hello")
            .padding(10)
            .background(Color.gray)
            .badge(count: 2)
        Collapsible(data: [1,2,3],expanded: true) { i in
           Text(String(i))
        }
    }
}
struct Collapsible<Element: Hashable, Content: View>: View {
    var data: [Element]
var expanded: Bool = false
var content: (Element) -> Content
    @ViewBuilder var body: some View {
        if expanded {
            HStack {
                ForEach(data, id: \.self) { d in
                    content(d)
                }
            }
        } else {
            ZStack{
                ForEach(data, id: \.self) { d in
                    content(d)
                }
            }
        }
    }
}

extension View  {
    func badge(count: Int) -> some View {
        return self
            .overlay(
                alignment: .topTrailing
            ) {
                if count > 1 {
                    Text(String(count))
                        .padding(5)
                        .background(
                            Circle()
                                .fill(.red)
                        )
                        .offset(CGSize(width: 10.0, height: -10.0))
                }
            }
    }
}

#Preview {
    LayoutView()
}
