//
//  WalletAnimation.swift
//  Guide
//
//  Created by Shivam Rawat on 11/08/23.
//

import SwiftUI

struct WalletAnimation: View {
    @State var cardSelected : Int?;
    let colors : [Color] = [Color.red, Color.green, Color.blue,Color.indigo]
    
    @Namespace var ns ;
    
    var body: some View {
            
            if cardSelected == nil {
                WalletList(cardSelected: $cardSelected, ns: ns,colors:colors)
            }
            else {
                WalletDetails(cardSelected:cardSelected, onPressingCard: {
                    self.cardSelected = nil;
                }, ns: ns,colors : colors)
            }
            
        
    }
}

struct WalletList : View {
    @State var selected : Bool = false ;
    @Binding var cardSelected : Int? ;
    var ns : Namespace.ID;
    var colors : [Color]
    var body: some View {
        VStack{
            ScrollView{
                LazyVStack {
                    ForEach(0...3, id:\.self) {index in
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(colors[index])
                            .matchedGeometryEffect(id:  "\(index)", in: ns)
                            .padding()
                            .offset(y : selected ? CGFloat(-100 * index) : 0)
                            .frame(height: 200)
                            .animation(.bouncy,value: selected)
                        
                            .onTapGesture {
                                withAnimation {
                                    cardSelected = index;
                                }
                            }
                    }
                }
            }
            Button {
                selected.toggle()
            } label : {
                Text("Wallet")
            }
        }
        
    }
}

struct WalletDetails : View {
    var color :Color = .teal;
    var cardSelected : Int? ;
    var onPressingCard : () -> Void;
    var ns : Namespace.ID;
    var colors : [Color]
    var body : some View {
        VStack{
            if let cardSelected {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(colors[cardSelected ?? 0] )
                    .matchedGeometryEffect(id: "\(cardSelected)", in: ns)
                    .padding()
                    .frame(height: 200)
                    .overlay{
                        VStack {
                            Text("\(cardSelected)")
                            
                        }
                    }
                    .onTapGesture {
                        onPressingCard()
                    }
            }
            Spacer()
        }
    }
}


#Preview {
    WalletAnimation()
}
