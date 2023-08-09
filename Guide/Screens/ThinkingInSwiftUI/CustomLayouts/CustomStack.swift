//
//  CustomStack.swift
//  Guide
//
//  Created by Shivam Rawat on 08/08/23.
//

import SwiftUI

struct Offsets : PreferenceKey {
    static let defaultValue: [Int : CGSize] = [.zero:CGSize()]
    static func reduce(value: inout [Int : CGSize], nextValue: () -> [Int : CGSize]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

struct ContentModifier : ViewModifier {
    var id: Int ;
    
    func body(content: Content) -> some View {
        GeometryReader { proxy in
            Color.clear.preference(key: Offsets.self, value: [id: CGSize(width: proxy.size.width, height: proxy.size.height)])
        }
    }
    
}

struct Stack <Element,Content : View> : View {
    var element : [Element] ;
    var axis : Axis  = .horizontal;
    var alignment : Alignment  = .topLeading;
    var spacingValue = 8.0;
    var content : (Element) -> Content ;
    
   @State var sizes : [CGPoint] = [];
    
    var body : some View {
        var _ = print(sizes)
        ZStack{
            ForEach(0..<element.count) {index in
                content(element[index])
                    .modifier(ContentModifier(id: index))
                    .alignmentGuide(self.alignment.horizontal, computeValue: {_ in 
                        self.axis == .horizontal
                        ? -self.sizes[index].x
                        : 9
                    })
                    .alignmentGuide(self.alignment.vertical, computeValue: {_ in 
                        self.axis == .vertical
                        ? -self.sizes[index].y
                         : 0
                    })
            }
        }.onPreferenceChange(Offsets.self, perform: { value in
            var offsets: [CGPoint] = [.zero]
            for idx in 0..<self.element.count {
                var newPoint = offsets.last!
                newPoint.x += value[idx]!.width + self.spacingValue
                newPoint.y += value[idx]!.height + self.spacingValue
                offsets.append(newPoint)
            }
            self.sizes = offsets
        })
        
    }
}

extension VerticalAlignment {
    struct CustomAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            return context[VerticalAlignment.center]
        }
    }

    static let custom = VerticalAlignment(CustomAlignment.self)
}


struct AlignmentView: View {
    var body: some View {
        HStack(alignment: VerticalAlignment.center) {
            Image(systemName: "star")
            VStack(alignment: .leading) {
                Text("Toronto")
                Text("Paris")
                Text("London")
                Text("Madrid")
                    .alignmentGuide(VerticalAlignment.center) { $0[VerticalAlignment.center] + 190 }
            }
        }.border(.red)
    }
}

struct CustomStack: View {
    var body: some View {
        AlignmentView()
        Stack(element: [Color.red,Color.green,Color.blue], axis: .vertical, alignment: .topLeading) { items in
            Rectangle()
                .fill(items)
                .frame(width: 100, height: 100)
        }.border(.gray)
    }
}

#Preview {
    CustomStack()
}
