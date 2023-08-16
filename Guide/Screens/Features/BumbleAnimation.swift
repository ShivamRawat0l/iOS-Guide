//
//  BumbleAnimation.swift
//  Guide
//
//  Created by Shivam Rawat on 16/08/23.
//

import SwiftUI

struct CardView : View {
    
     var DATA_COLLECTION = ["Hello", "Bye", "Another" , "First","Second","Third","Fourth","Fifth", "Sixth", "Seventh"]
    var COLORS : [Color] = [.green,.teal,.gray,.purple,.orange,.cyan,.blue ,.mint,.indigo,.yellow,.white]
    var OPACITY = [1,0.9,0.8, 0.7]
    
    @State var offset = CGSize.zero
    @Binding var selectedIndex : Int ;
    
    var index : Int ;
    var relativeIndex :  Int;
    
    init(selectedIndex: Binding<Int> , index: Int) {
        self.index = index
        self._selectedIndex = selectedIndex
        self.relativeIndex =  index - selectedIndex.wrappedValue;
    }
    
    var body : some View {
        RoundedRectangle(cornerRadius: 25.0)
            .fill(COLORS[index])
            .opacity(OPACITY[relativeIndex])
            .background(.red)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .padding()
            .frame(height: 300)
            .overlay{
                Text(DATA_COLLECTION[index])
                    .font(.system(size: 24))
                    .bold()
            }
            .scaleEffect(x:OPACITY[relativeIndex], y: OPACITY[relativeIndex],anchor: .bottom)
            .offset(x: offset.width ,y: CGFloat(20 * relativeIndex ))
            .rotationEffect(Angle(degrees:  CGFloat(offset.width / 40)),anchor: .bottom)
            .animation(.linear,value:DATA_COLLECTION)
            .zIndex(Double(DATA_COLLECTION.count - index))
            .gesture(
                DragGesture().onChanged({ gesture in
                    print(gesture.translation)
                    offset =  gesture.translation
                })
                .onEnded({ gesture in
                    
                    if abs(offset.width) > 200.0 {
                        withAnimation(.linear(duration: 0.1)) {
                            if offset.width > 200.0 {
                                offset = CGSize(width: 500, height: 0)
                            }
                            else {
                                offset = CGSize(width: -500, height: 0)
                            }
                        }

                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                          //  offset = CGSize(width: 0, height: 0)
                            withAnimation {
                                selectedIndex += 1
                            }
                        }
                    } else {
                        withAnimation {
                            offset = CGSize.zero
                        }
                    }
                })
            )
    }
}

struct BumbleAnimation: View {
    @State var selectedIndex = 0
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.red)
            ForEach(selectedIndex...(selectedIndex + 3), id: \.self){index in
                if index < 10 {
                    CardView(selectedIndex: $selectedIndex, index: index)
                }
            }
        }
    }
}

#Preview {
    BumbleAnimation()
}
