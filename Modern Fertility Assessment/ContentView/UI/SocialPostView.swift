//
//  SocialPostListView.swift
//  Modern Fertility Assessment
//
//  Created by Adam Ure on 2/2/22.
//

import SwiftUI

struct SocialPostListView: View {
    private struct Constants {
        static let horizontalPadding: CGFloat = 16
        static let cornerRadius: CGFloat = 8
        static let overlayHeight: CGFloat = 80
        static let titleLineLimit: Int = 1
    }
    
    // TODO: Store isLiked locally to remember which ones were liked
    @State var isLiked: Bool = false
    let post: SocialPost

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                AsyncImage(url: URL(string: post.thumbnailUrl)) {
                    phase in
                    switch phase {
                        case .success(let image):
                            image.resizable().scaledToFill()
                        default:
                            Rectangle().fill(Color.gray)
                    }
                }
                VStack {
                    Spacer()
                    HStack(spacing: Constants.horizontalPadding) {
                        Text(post.title).font(.title).fontWeight(.semibold).lineLimit(Constants.titleLineLimit).foregroundColor(.white).padding(.leading, Constants.horizontalPadding)
                        Spacer()
                        Button(action: {
                            isLiked.toggle()
                        }) {
                            Image(systemName: isLiked ? "heart.fill" : "heart").tint(.red)
                        }.padding(.trailing, Constants.horizontalPadding)
                    }.frame(width: geometry.size.width).padding(.vertical).background(Rectangle().fill(Color.gray.opacity(0.9)))
                }
            }.frame(width: geometry.size.width).clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
        }
    }
}

struct SocialPostListView_Previews: PreviewProvider {
    static var previews: some View {
        SocialPostView(post: SocialPost(albumId: 1, id: 1, title: "Test", url: "https://via.placeholder.com/150/51aa97", thumbnailUrl: "https://via.placeholder.com/150/51aa97"))
    }
}
