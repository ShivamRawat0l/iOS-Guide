//
//  RoundedCornerShape.swift
//  Guide
//
//  Created by Shivam Rawat on 31/07/23.
//

import SwiftUI

struct MessageBubble: Shape{
    var radius : CGFloat =  40.0  ;
    
    func calculateRadius(rect: CGRect)-> CGFloat {
        if rect.width < rect.height {
            if rect.width < 2 * radius {
                return   rect.width / 2
            }
            else {
                return radius
            }
        } else {
            if rect.height < 2 * radius {
                return rect.height / 2
            }
            else {
                return radius
            }
        }
    }
    
    func path(in rect: CGRect) -> Path {
        // Note: calculates the possible radius for the message bubble
        let calculatedRadius = calculateRadius(rect: rect)
        // Note: calculates offsets for the bezier curves
        let halfRadius = calculatedRadius / 2;
        
        var path = Path();
        path.move(to: CGPoint(x: rect.width / 2, y: 0))
        path.addLine(to: CGPoint(x: rect.width - calculatedRadius, y: 0))
        path.addCurve(to: CGPoint(x: rect.width, y: calculatedRadius), control1: CGPoint(x: rect.width - halfRadius, y: 0 ), control2: CGPoint(x: rect.width, y:  halfRadius))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height - calculatedRadius))
        path.addCurve(to: CGPoint(x: rect.width - calculatedRadius, y: rect.height), control1: CGPoint(x: rect.width  , y: rect.height - halfRadius),control2: CGPoint(x: rect.width - halfRadius, y:  rect.height))
        path.addLine(to: CGPoint(x: calculatedRadius, y: rect.height))
        path.addCurve(to: CGPoint(x: 0 , y: rect.height - calculatedRadius), control1: CGPoint(x: calculatedRadius - halfRadius, y: rect.height ),control2: CGPoint(x: 0, y:  rect.height - halfRadius))
        path.addLine(to: CGPoint(x: 0, y: halfRadius))
        path.addCurve(to: CGPoint(x: halfRadius, y: 0), control1: CGPoint(x: 0 , y: 0),control2: CGPoint(x: 0, y:  0))
        path.addLine(to: CGPoint(x: rect.width / 2, y: 0))
        path.closeSubpath()
        return path
    }
}
