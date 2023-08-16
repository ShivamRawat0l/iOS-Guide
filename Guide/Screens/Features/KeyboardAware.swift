//
//  KeyboardAware.swift
//  Guide
//
//  Created by Shivam Rawat on 10/08/23.
//

import SwiftUI

struct KeyboardAware: View {
    @State var text : String = "";
    
    var body: some View {
        ZStack {
            ScrollView {
                Spacer()
                TextField("Enter Name ", text: $text)
                Spacer()
                Rectangle()
                    .fill(Gradient(colors: [.red,.green]))
                    .overlay{
                        Text("HEKRE")
                    }
                    .frame(height: 200)
                Rectangle()
                    .fill(Gradient(colors: [.yellow,.green]))
                    .frame(height: 400)
                Rectangle()
                    .fill(.blue)
                    .frame(height: 200)
                //     .ignoresSafeArea(.keyboard)
            }
        }
    
    }
}

#Preview {
    KeyboardAware()
}
