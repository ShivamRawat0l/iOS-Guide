//
//  TableView.swift
//  Guide
//
//  Created by Shivam Rawat on 08/08/23.
//

import SwiftUI

struct Details : Equatable {
    var x : Int  ;
    var y : Int ;
    var height : CGFloat ;
    var width : CGFloat ;
}

struct TablePreference : PreferenceKey {
    
    static let defaultValue: [Details] = [];
    static func reduce(value: inout [Details], nextValue: () -> [Details]) {
        value.append(contentsOf: nextValue())
    }
}

struct AnchorPreference : PreferenceKey {
    static let defaultValue: Anchor<CGRect>? = nil  ;
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value ?? nextValue()
    }
}


extension View {
    func sizePreference(index: Int, cell: Int) -> some View {
        Color.clear
    }
}


struct Table<Content:View> : View {
    var cells : [[Content]];
    var sizes : [CGFloat?] ;
    @State  var selected  : ( Int , Int)? = nil
    
    func checkSelected(selected : (Int, Int)? , x:Int , y: Int ) -> Bool  {
        if let selected {
            if selected.0 == x && selected.1 == y {
                return true
            }
            else {
                return false
            }
        }
        return false
    }
    
    var body : some View {
        VStack(alignment: .leading){
            ForEach(0..<cells.count, id:\.self) { cell in
                HStack {
                    ForEach(0..<4, id:\.self) {index in
                        cells[cell][index]
                            .background(GeometryReader { proxy in
                                Color.clear
                                    .anchorPreference(key: AnchorPreference.self, value: .bounds, transform: { anchor in
                                        if checkSelected(selected: selected, x: index, y: cell) {
                                            return anchor
                                        } else {
                                            return nil
                                        }
                                    })
                                    .preference(key: TablePreference.self,
                                                value: [
                                                    Details(
                                                        x: index,
                                                        y : cell ,
                                                        height : proxy.size.height,
                                                        width: proxy.size.width
                                                    )
                                                ]
                                    )
                            })
                            .onTapGesture(perform: { _ in
                                let a = (index,cell)
                                withAnimation {
                                    selected = a;
                                }
                            })
                            .frame(width: sizes[index])
                        //.border(checkSelected(selected: selected, x: index, y: cell))
                    
                    }
            
                }
           
                .frame(height: 70)
            }
        }
        .overlayPreferenceValue(AnchorPreference.self, { anchor in
            if anchor != nil {
                GeometryReader {proxy in
                    Rectangle()
                        .fill(.clear)
                        .border(.blue)
                        .frame(width: proxy[anchor!].width,height: proxy[anchor!].height)
                        .offset(x: proxy[anchor!].minX, y: proxy[anchor!].minY)
                }
            }
        })
    }
}

struct TableView: View {
    @State var sizes : [CGFloat?] = [nil,nil,nil,nil];
    var cells = [
        [
            Text(""),
            Text("M").bold(),
            Text("Tuesday").bold(),
            Text("Wednesday").bold()
        ],
        [
            Text("Berlin").bold(),
            Text("Cloudy"),
            Text("Mostly\nSunny"),
            Text("Sunny")
        ],
        [
            Text("London").bold(),
            Text("Heavy Rain"),
            Text("Cloudy"),
            Text("Sunny")
        ],
    ]
    
    var body: some View {
        Table(cells: cells,sizes: sizes)
            .font(Font.system(.body, design: .serif))
            .padding()
            .onPreferenceChange(TablePreference.self, perform: { value in
                for i in value.indices {
                    if sizes[value[i].x] == nil ||  sizes[value[i].x]! < value[i].width {
                        sizes[value[i].x] = value[i].width;
                    }
                }
            })
    }
}

#Preview {
    TableView()
}
