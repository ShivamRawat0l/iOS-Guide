//
//  ImageSearch.swift
//  Guide
//
//  Created by Shivam Rawat on 31/08/23.
//

import SwiftUI

fileprivate struct ImagesearchDetail : View {
    var ns : Namespace.ID;
    @StateObject var imageSearchVC : ImageSearchViewController ;
    
    var body : some View {
        VStack {
            AsyncImage(url: URL(string: imageSearchVC.imageURL ?? "") , content:  { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
            }, placeholder:  {
                ProgressView()
            })
            .matchedGeometryEffect(id: "image\(imageSearchVC.imageID ?? "")", in: ns)
            .onTapGesture {
                withAnimation {
                    imageSearchVC.imageURL = nil;
                }
            }
            VStack {
                Text("\(imageSearchVC.imageID ?? "")")
                    .font(.system(size: 20))
                    .bold()
                    .multilineTextAlignment(.center)
            }
            .padding()
            Spacer()
        }
    }
}

fileprivate struct ImageSearch: View {
    @State var searchText : String = "";
    var ns : Namespace.ID;
    @StateObject var imageSearchVC : ImageSearchViewController ;
    
    var body: some View {
        VStack {
            HStack {
                TextField("Seach Image", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.system(size: 18))
                    .padding()
                Button {
                    Task{
                        await imageSearchVC.fetchImages(searchText : searchText);
                    }
                } label : {
                    Image(systemName: "play")
                }
            }
            .padding()
            ScrollView {
                VStack {
                    ForEach(imageSearchVC.images, id: \.0) { image in
                        VStack {
                            AsyncImage(url: URL(string: image.1) , content:  { phase
                                in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .frame(height: 200)
                                        .aspectRatio(contentMode: .fill)
                                    
                                case .failure(let error):
                                    let _ = print(error)
                                    Text("error: \(error.localizedDescription)")
                                case .empty:
                                    ProgressView()
                                @unknown default:
                                    fatalError()
                                }
                            })
                            .matchedGeometryEffect(id: "image\(image.0)", in: ns)
                            .onTapGesture {
                                imageSearchVC.imageID = image.0;
                                withAnimation{
                                    imageSearchVC.imageURL = image.1;
                                }
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct FlickerImage : View {
    @Namespace var ns
    @StateObject var imageSearchVC  = ImageSearchViewController()
    
    var body : some View {
        ZStack {
            ImageSearch(ns: ns , imageSearchVC : imageSearchVC)
                .opacity(imageSearchVC.imageURL != nil ? 0 : 1)
            if let _ = imageSearchVC.imageURL,
               let _ =  imageSearchVC.imageID {
                ImagesearchDetail(ns: ns, imageSearchVC : imageSearchVC )
            }
        }
    }
}

#Preview {
    @Namespace var ns;
    @StateObject var imageSearchVC  = ImageSearchViewController()
    
    return ImageSearch(ns : ns , imageSearchVC : imageSearchVC)
}
