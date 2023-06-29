//
//  OnboardingView.swift
//  Guide
//
//  Created by Shivam Rawat on 20/06/23.
//

import SwiftUI

let NUMBER_OF_SCREENS : Int = 5;

struct OnboardingView: View {
    @State var horizontalY = 0.0;
    @State var currentY  = 0.0;
    @State var animatedWidth : [CGFloat] = Array(repeating: 8.0, count: NUMBER_OF_SCREENS)
    
    func interpolate(_ interpolateValue : CGFloat, _ inputRange: [CGFloat],_ outputRange: [CGFloat]) -> CGFloat {
        var rangeIndex = -1;
        if inputRange.count != outputRange.count {
            return -1;
        }
        for i in 0..<inputRange.count {
            if interpolateValue < inputRange[i] {
                rangeIndex = i ;
                break;
            }
        }
        if rangeIndex == -1 {
            return outputRange[outputRange.count - 1]
        }
        if rangeIndex == 0 {
            return outputRange[0]
        }
     
        let conversion : CGFloat =  (interpolateValue - inputRange[rangeIndex-1]) * ((outputRange[rangeIndex] -  outputRange[rangeIndex-1]) / (inputRange[rangeIndex] - inputRange[rangeIndex-1]));
        let interpolatedValue = outputRange[rangeIndex-1] + conversion;
     
        return  interpolatedValue
    }
    
    var body: some View {
        ZStack{
            HStack( spacing: 0){
                VStack {
                    Text("First")
                }
                .frame(width: Constants.width,height: Constants.height)
                .background(.red)
                
                VStack {
                    
                    Text("First")
                }
                .frame(width: Constants.width, height: Constants.height)
                .background(.brown)
                VStack {
                    
                    Text("First")
                }
                .frame(width: Constants.width, height: Constants.height)
                .background(.yellow)
                VStack {
                    
                    Text("First")
                }
                .frame(width: Constants.width, height: Constants.height)
                .background(.cyan)
                VStack{
                    
                    Text("First")
                }
                .frame(width: Constants.width, height: Constants.height)
                .background(.blue)

            }
            .offset(x : ( Constants.width * CGFloat(Int( NUMBER_OF_SCREENS / 2 )) ) + horizontalY)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                       
                        
                        if currentY + value.translation.width > 0 {
                            return
                        }
                        horizontalY = currentY + value.translation.width
                        for index in 0..<animatedWidth.count{
                            let outputRangePrevious = CGFloat(index-1) * Constants.width ;
                            let outputRangeCurrent = CGFloat(index) * Constants.width ;
                            let outputRangeNext = CGFloat(index+1) * Constants.width ;
                            let inputRange  =  [outputRangePrevious,outputRangeCurrent,outputRangeNext];
                            withAnimation {
                                animatedWidth[index] =  interpolate(abs(horizontalY), inputRange,[8,25, 8])

                            }
                        }
                    })
                
                    .onEnded({ value in
                        horizontalY = round(horizontalY / Constants.width) * Constants.width;
                        currentY = horizontalY;
                        print(animatedWidth)

                        for index in 0..<animatedWidth.count{
                            let outputRangePrevious = CGFloat(index-1) * Constants.width ;
                            let outputRangeCurrent = CGFloat(index) * Constants.width ;
                            let outputRangeNext = CGFloat(index+1) * Constants.width ;
                            let inputRange  =  [outputRangePrevious,outputRangeCurrent,outputRangeNext];
                            withAnimation {
                                animatedWidth[index] =  interpolate(abs(horizontalY), inputRange,[8,25, 8])

                            }
                        }
                        print(animatedWidth)
                    })
            )
            .animation(.default ,value: horizontalY)
            HStack  {
                ForEach(0..<NUMBER_OF_SCREENS) {index in
                    
                    Capsule()
                        .fill(.green)
                        .frame(
                            width:  animatedWidth[index],
                            height: 8
                        )
                        .animation(.spring,value: horizontalY)
                }
            }
            .onAppear(perform: {
                animatedWidth[0] = 25.0;
            })
            .frame(height: Constants.height, alignment: .bottom)
            .offset(y: -30)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
