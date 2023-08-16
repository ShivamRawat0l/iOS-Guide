//
//  TabScreen.swift
//  Guide
//
//  Created by Shivam Rawat on 11/08/23.
//

import SwiftUI

enum Screens {
    case first
    case second
}

struct TabScreen: View {
    
    @State var selected = 1;
    var body: some View {
        var _ = print(selected)
        VStack{
            Rectangle()
                .fill(selected == 5 ? .green: .teal)
            TabView(selection: $selected){
                Rectangle()
                    .fill(.red)
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Hello")
                    }
                    .tag(2)
                Rectangle()
                    .fill(.blue)
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Hello")
                            .foregroundColor(.red)
                            .foregroundStyle(.red)
                    }
                    .tag(1)
                    .accentColor(.green)
            }
        }
        //.accentColor(.teal)
    }
    
}

#Preview {
    TabScreen()
}
