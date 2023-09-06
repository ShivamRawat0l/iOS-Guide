//
//  ImageSearch.swift
//  Guide
//
//  Created by Shivam Rawat on 31/08/23.
//

import SwiftUI

fileprivate struct ImagesearchDetail : View {
    var ns : Namespace.ID;
    @EnvironmentObject var flickerStore : FlickerStore;
    
    var body : some View {
        VStack {
            AsyncImage(url: URL(string: flickerStore.state.imageURL ?? "") , content:  { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
            }, placeholder:  {
                ProgressView()
            })
            .matchedGeometryEffect(id: "image\(flickerStore.state.imageID!)", in: ns)
            .onTapGesture {
                withAnimation {
                    flickerStore.state.imageURL = nil;
                }
            }
            VStack {
                Text("\(flickerStore.state.imageID!)")
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
                                flickerStore.state.imageID = image.0
                                withAnimation {
                                    flickerStore.state.imageURL = image.1
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

struct FlickerImageRedux : View {
    @Namespace var ns ;
    @EnvironmentObject var flickerStore : FlickerStore;
    
    var body : some View {
        ZStack {
            ImageSearch(ns: ns)
                .opacity(flickerStore.state.imageURL == nil ? 1 : 0 )
            if let _ = flickerStore.state.imageURL,
               let _ = flickerStore.state.imageID {
                ImagesearchDetail(ns: ns )
            }
        }
    }
}

#Preview {
    @Namespace var ns;
    return ImageSearch(ns : ns )
}
