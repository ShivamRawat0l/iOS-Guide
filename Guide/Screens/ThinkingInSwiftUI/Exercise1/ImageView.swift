//
//  ImageView.swift
//  Guide
//
//  Created by Shivam Rawat on 03/08/23.
//

import SwiftUI

struct ImageView: View {
    var downloaded_url : URL;
    @State var imageData : Data?;
    
    
    var body: some View {
        VStack {
            if let imageData , let image = UIImage(data:imageData){
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            
            URLSession.shared.dataTask(with: downloaded_url) {data , response ,error in
                print("Here")
                if let error {
                    print("An error Occured ", error)
                }
                if let data {
                    print(downloaded_url)
                    self.imageData =  data
                }
            }
            .resume()
        }
    }
}
