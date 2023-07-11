//
//  AnimationHelper.swift
//  Guide
//
//  Created by Shivam Rawat on 30/06/23.
//

import Foundation


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
