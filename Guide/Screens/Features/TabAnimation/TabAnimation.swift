//
//  TabAnimation.swift
//  Guide
//
//  Created by Shivam Rawat on 17/08/23.
//

import SwiftUI

let Tabs = [
    ("house.fill", "Home"),
    ("gear.circle", "Setting"),
    ("person.circle.fill", "About")
]

struct CustomTab : View {
    var selected : Bool = false
    var iconName : String ;
    var tabName : String;
    var onTabSelected : () -> Void
    
    var body : some View {
        VStack {
            Image(systemName: iconName)
                .foregroundColor(selected ?  Color("naturegreen"): Color("brown") )
            Text(tabName)
            
        }
        .scaleEffect(selected ? 1.2 : 1)
        .frame(width: 60,height: 60)
        .onTapGesture {
            self.onTabSelected()
        }
    }
}

struct TabAnimation: View {
    var body : some View {
        ZoomAnimation()
        BarTabAnimation()
        CircleAnimation()
    }
}

struct ZoomAnimation : View {
    @State var selectedTab : Int = 1 ;
    
    var body: some View {
        switch selectedTab {
        case 0 :
            Text("First")
        case 1 :
            Text("Second")
        case 2 :
            Text("Third")
        default :
            Text("Wrong ScreenProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)")
        }
        Spacer()
        ZStack {
            RoundedRectangle(cornerRadius: 20.0)
                .fill(Color("offwhite"))
                .opacity(0.6)
                .frame(height: 70)
            HStack(alignment: .center){
                Spacer()
                ForEach(0..<3, id: \.self) { index in
                    CustomTab(selected: index == selectedTab, iconName:  Tabs[index].0, tabName : Tabs[index].1) {
                        selectedTab = index;
                    }
                    .animation(.linear(duration: 0.1), value: selectedTab)
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
        .frame(height: 100,alignment: .bottom)
    }
}
struct BarTab : View {
    var index : Int ;
    var iconName : String ;
    var tabName : String;
    var ns : Namespace.ID ;
    var onTabSelected : () -> Void
    var body : some View {
        VStack {
            Image(systemName: iconName)
                .foregroundColor(Color("brown"))
            Text(tabName)
        }
        .matchedGeometryEffect(id:index, in: ns)
        .frame(width: 60,height: 60)
        .onTapGesture {
            self.onTabSelected()
        }
    }
}


struct BarTabAnimation : View {
    @State var selectedTab : Int = 1 ;
    
    @Namespace var ns;
    var body: some View {
        switch selectedTab {
        case 0 :
            Text("First")
        case 1 :
            Text("Second")
        case 2 :
            Text("Third")
        default :
            Text("Wrong ScreenProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)")
        }
        Spacer()
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color("offwhite"))
                .opacity(0.6)
                .frame(height: 80)
            HStack(alignment: .center){
                Spacer()
                ForEach(0..<3, id: \.self) { index in
                    BarTab(index: index, iconName:  Tabs[index].0, tabName : Tabs[index].1, ns : ns) {
                        withAnimation {
                            selectedTab = index;
                        }
                    }
                    Spacer()
                }
                .overlay(alignment: .top) {
                    Rectangle()
                        .fill(Color("naturegreen"))
                        .frame(height: 6)
                        .offset(y:-52)
                        .matchedGeometryEffect(id: selectedTab, in: ns ,isSource: false)
                }
            }
        }
        .padding(.horizontal)
    }
}

struct CircleTab : View {
    var index : Int;
    var iconName : String ;
    var tabName : String;
    var ns : Namespace.ID;
    var onTabSelected : () -> Void
    
    var body : some View {
        VStack {
            Image(systemName: iconName)
                .foregroundColor(Color("brown"))
                .frame(width: 50,height: 50)
        }
        .matchedGeometryEffect(id:index, in: ns)
        .frame(width: 80,height: 80)
        .onTapGesture {
            self.onTabSelected()
        }
    }
}


struct CircleAnimation : View {
    @State var selectedTab : Int = 1 ;
    @Namespace var ns;
    var body: some View {
        switch selectedTab {
        case 0 :
            Text("First")
        case 1 :
            Text("Second")
        case 2 :
            Text("Third")
        default :
            Text("Wrong ScreenProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)")
        }
        Spacer()
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color("offwhite"))
                .opacity(0.6)
                .frame(height: 50)
            HStack(alignment: .center){
                Spacer()
                ForEach(0..<3, id: \.self) { index in
                    CircleTab(index: index, iconName:  Tabs[index].0, tabName : Tabs[index].1, ns :ns) {
                        withAnimation {
                            selectedTab = index;
                        }
                    }
                    .offset(y : selectedTab == index ? -20 : 0 )
                    .animation(.linear(duration: 0.1), value: selectedTab)
                    Spacer()
                }
            }
            .background {
                Circle()
                    .fill(Color("naturegreen"))
                    .matchedGeometryEffect(id: selectedTab, in: ns ,isSource: false)
            }
        }
        .padding(.horizontal)
    }
}


#Preview {
    TabAnimation()
}
