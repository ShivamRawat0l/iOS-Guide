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
    
    @AppStorage("onboardingComplete") var onboardingComplete = false;
    
    func animateCapsule(){
        for index in 0..<animatedWidth.count{
            let outputRangePrevious = CGFloat(index-1) * Constants.width ;
            let outputRangeCurrent = CGFloat(index) * Constants.width ;
            let outputRangeNext = CGFloat(index+1) * Constants.width ;
            let inputRange  =  [outputRangePrevious,outputRangeCurrent,outputRangeNext];
            withAnimation{
                animatedWidth[index] =  interpolate(abs(horizontalY), inputRange,[8,25, 8])
            }
        }
    }
    
    func onChange(value:DragGesture.Value){
        let newPosition = currentY + value.translation.width;
        if newPosition > 0 || abs(newPosition) >  Constants.width * CGFloat(NUMBER_OF_SCREENS - 1) {
            return
        }
        horizontalY = newPosition;
        animateCapsule();
    }
    
    func onEnd(value:DragGesture.Value){
        let offset = abs(value.predictedEndTranslation.width) > Constants.width ?  (value.predictedEndTranslation.width / abs(value.predictedEndTranslation.width)) * Constants.width : value.predictedEndTranslation.width
        let newPosition = round((horizontalY + offset / 2) / Constants.width) * Constants.width;
        if newPosition > 0 || abs(newPosition) >  Constants.width * CGFloat(NUMBER_OF_SCREENS - 1) {
            return
        }
        withAnimation(.easeIn(duration: 0.1)){
            horizontalY = newPosition;
        }
        currentY = horizontalY;
        animateCapsule()
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
                    Button {
                        onboardingComplete = true;
                    }
                    label : {
                        Text("Navigate to the HomeScreen.")
                    }
                }
                .frame(width: Constants.width, height: Constants.height)
                .background(.blue)
            }
            .offset(x : ( Constants.width * CGFloat(Int( NUMBER_OF_SCREENS / 2 )) ) + horizontalY)
            .gesture(
                DragGesture()
                    .onChanged(onChange)
                    .onEnded(onEnd)
            )
            
            HStack  {
                ForEach(0..<NUMBER_OF_SCREENS) {index in
                    Capsule()
                        .fill(.green)
                        .frame(
                            width:  animatedWidth[index],
                            height: 8
                        )
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
