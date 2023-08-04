//
//  ImageListView.swift
//  Guide
//
//  Created by Shivam Rawat on 03/08/23.
//

import SwiftUI

let listUrl = "https://picsum.photos/v2/list"

struct ImageListView: View {
    @StateObject var imageListController = Remote()
    @State var selectedImageUrl : URL? ;
    var body: some View {
        VStack{
            NavigationView {
                if let images = imageListController.imageList  {
                    ScrollView{
                        ForEach(images){ image in
                            NavigationLink {
                                ImageView(downloaded_url: URL(string:image.download_url)!)
                            } label: {
                            HStack{
                                Text(image.url)
                                    .lineLimit(nil)
                                Text(image.author)
                                VStack {
                                    Text(String(image.height))
                                    Text(String(image.width))
                                }
                            }
                            .padding()
                            }
                        }
                    }
                }
                else {
                    ProgressView()
                    
                }
            }
        }
        .onAppear {
            self.imageListController.onLoad()
        }
    }
}

#Preview {
    ImageListView()
}
