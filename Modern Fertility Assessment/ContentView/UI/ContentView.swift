//
//  ContentView.swift
//  Modern Fertility Assessment
//
//  Created by Adam Ure on 2/2/22.
//

import SwiftUI

struct ContentView: View {
    private struct Constants {
        static let bodyHorizontalPadding: CGFloat = 16
        static let emptySpacing: CGFloat = 0
    }

    @StateObject var viewModel = ContentViewModel(networkProvider: DefaultRemoteNetworkProvider())

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: Constants.emptySpacing) {
                    Text(NSLocalizedString("title", comment: "Modern Fertility")).foregroundColor(.black).font(.largeTitle).bold().padding(.horizontal, Constants.bodyHorizontalPadding).padding(.vertical)
                    Divider().padding(.horizontal, Constants.bodyHorizontalPadding)
                    ForEach(viewModel.posts, id: \.id) { post in
                        SocialPostView(post: post).frame(height: geometry.size.width).padding().onTapGesture{
                            viewModel.selectedPost = post
                        }
                    }
                    
                }
            }.sheet(isPresented: $viewModel.shouldShowDetails, onDismiss: {
                viewModel.selectedPost = nil
            }) {
                SocialPostDetailsView(post: viewModel.selectedPost!).frame(width: geometry.size.width)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ContentViewModel(networkProvider: DefaultRemoteNetworkProvider())
        ContentView(viewModel: viewModel).onAppear(perform: {
            viewModel.posts.append(
                contentsOf: [
                    SocialPost(albumId: 1, id: 1, title: "Test", url: "Test", thumbnailUrl: "Test"),
                    SocialPost(albumId: 2, id: 2, title: "Test 2", url: "Test 2", thumbnailUrl: "Test 2")
                ]
            )
            
        })
    }
}
