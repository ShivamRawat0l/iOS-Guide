//
//  ImageSearch.swift
//  Guide
//
//  Created by Shivam Rawat on 31/08/23.
//

import SwiftUI

fileprivate struct ImagesearchDetail : View {
    var imageURL : String;
    var imageID : String;
    var ns : Namespace.ID;
    var onPressImage : () -> Void ;
    
    var body : some View {
        VStack {
            AsyncImage(url: URL(string: imageURL) , content:  { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
            }, placeholder:  {
                ProgressView()
            })
            .matchedGeometryEffect(id: "image\(imageID)", in: ns)
            .onTapGesture {
                onPressImage();
            }
            VStack {
                Text("\(imageID)")
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
    @EnvironmentObject var flickerStore : FlickerStore ;
    @State var searchText : String = "";
    var ns : Namespace.ID;
    var onPressImage : (_ url : String, _ name : String ) -> Void ;
    
    var body: some View {
        VStack {
            HStack {
                Text("Redux")
                TextField("Seach Image", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.system(size: 18))
                    .padding()
                Button {
                    Task{
                        await flickerStore.dispatch(Action.fetch(searchText))
                    }
                } label : {
                    Image(systemName: "play")
                }
            }
            .padding()
            ScrollView {
                VStack {
                    ForEach(flickerStore.state.images, id: \.0) { image in
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
                                onPressImage(image.1,image.0);
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct FlickerImageRedux : View {
    @State var imageURL : String?;
    @State var imageID : String?;
    @Namespace var ns ;
    
    @EnvironmentObject var flickerStore : FlickerStore;
    var body : some View {
        ZStack {
            ImageSearch(ns: ns ,onPressImage: { image, id in
                imageID = id;
                withAnimation{
                    imageURL = image;
                }
            })
            .opacity(imageURL == nil ? 1 : 0 )
            if let imageURL,let imageID {
                ImagesearchDetail(imageURL: imageURL, imageID: imageID,  ns: ns , onPressImage : {
                    withAnimation {
                        self.imageURL = nil;
                        self.imageID = nil;
                    }
                })
            }
        }
    }
}

#Preview {
    @Namespace var ns;
    @StateObject var imageSearchVC  = ImageSearchViewController()
    
    return ImageSearch(ns : ns ,  onPressImage:  {image , id  in
        print(image)
        print(id)
    })
}
