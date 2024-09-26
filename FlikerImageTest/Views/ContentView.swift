
// FlikerImageTest
//
//  Created by Reshmi Divi on 26/09/24.
//
import SwiftUI
import Combine
import Foundation
import SDWebImageSwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            GridCView()
        }
    }
}
#Preview {
    ContentView()
}
struct GridCView: View {
    @State var isHidden:Bool = false
    @State var shouldPresenView = false
    @State var statusText:String = "Please enter text to display the images"
    @ObservedObject var viewModel = ImageListViewModel()
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 150)),
      
    ]
    
    var body: some View {
        ScrollView {
            Text(statusText).opacity(isHidden ? 0 : 1)
            LazyVGrid(columns: self.columns) {
                ForEach(viewModel.images, id: \.title) { image in
                    NavigationLink (
                        destination: ImageDetailView(image: image),
                        label: {
                            WebImage(url: URL(string: image.media.m))
                                .resizable()
                                .indicator(.activity)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 150, height: 150)
                                .cornerRadius(14)
                                .clipped()
                            
                        })
                }
                
            }.listStyle(.plain)
                .navigationTitle("Search Image")
                .searchable(text: $viewModel.searchText)
                .onChange(of: viewModel.searchText) { searchText in
                    if !searchText.isEmpty{
                        Task {
                            isHidden =  true
                            await viewModel.fetchData()
                        }
                    }else{
                        viewModel.images = []
                        isHidden =  false
                    }
                }
            
        }
        .padding()
    }
}

