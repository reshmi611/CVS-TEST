//
//  ImageDetailView.swift
// FlikerImageTest
//
//  Created by Reshmi Divi on 26/09/24.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI
import WebKit
struct ImageDetailView: View {
    @State var image:Item
    var body: some View {
        NavigationStack {
            DetailView(image: $image)
        }
    }
}

struct DetailView: View {
    @Binding var image:Item
    @State private var size: CGSize = .zero

    var body: some View {
        ScrollView{
            VStack{
                WebImage(url: URL(string: image.media.m))
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(14)
                    .clipped()
                CardText.padding(.horizontal,8)
            }
        }
    }
    
    var CardText:some View{
        VStack(alignment: .leading){
            Text(image.title).font(.headline)
            Text(image.author).foregroundColor(.orange).font(.subheadline)
            Text(image.published).foregroundColor(.blue).font(.subheadline)
            HtmlText(htmlContent:image.description, size: $size)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: size.height, maxHeight: .infinity)
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
          
            
        
    }
}

