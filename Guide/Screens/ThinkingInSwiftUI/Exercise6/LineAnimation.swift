//
//  LineAnimation.swift
//  Guide
//
//  Created by Shivam Rawat on 09/08/23.
//

import SwiftUI

struct LineGraph : Shape {
    
    var dataPoints : [CGFloat] ;
    
    func path(in rect : CGRect) -> Path {
        Path({path in
        path.move(to: CGPoint(x: 0, y: 0))
            for index in dataPoints.indices {
                let x = CGFloat(index * 50);
                let y = dataPoints[index] * 200
                path.addLine(to: CGPoint(x: x, y:y))
            }
            //ForEach(dataPoints.indices) { index in
             //   path.addLine(to: CGPoint(x: 2.0, y: 2.0))
              //  path.addLine(to: CGPoint(x: CGFloat(index), y: dataPoints[index]))
            //}
        })
    }
}

struct LineAnimation: View {
    let defaultData: [CGFloat] = [0.1, 0.7, 0.3, 0.6, 0.45, 1.1,0.4]
    @State var sampleData : [CGFloat] = []
    
    var body: some View {
        VStack(alignment: .leading){
            LineGraph(dataPoints: sampleData)
                .trim(from: 0 , to :sampleData.count > 0 ? 1 : 0  )
                .stroke(Color.red, lineWidth: 2)
                .overlay(
                    GeometryReader { proxy in
                        if sampleData.count > 0 {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 10, height: 10,alignment: .topLeading)
                                .offset(x:  ((CGFloat(sampleData.count) - 1.0 ) * 50.0) - 10/2 ,  y: (200.0 * sampleData.last!) - 10/2 )
                        }
                    }
                )
                .border(Color.gray, width: 1)
                .padding()
                .background(.green)
             
                .onAppear{
                    //
                }
    
            //.position(on: LineGraph(dataPoints: sampleData), at: visible ? 1 : 0)
            Button {
               sampleData = []
                withAnimation(.linear) {
                    sampleData = self.defaultData;
                }
            } label : {
                Circle()
            }
        }
    }
}

#Preview {
    LineAnimation()
}
