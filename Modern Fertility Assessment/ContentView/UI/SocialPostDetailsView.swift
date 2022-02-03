//
//  SocialPostDetailsView.swift
//  Modern Fertility Assessment
//
//  Created by Adam Ure on 2/2/22.
//

import SwiftUI

struct SocialPostDetailsView: View {
    private struct Constants {
        static let emptySpacing: CGFloat = 0
        static let horizontalPadding: CGFloat = 16
        static let buttonVertical: CGFloat = 4
    }
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
                        Text(post.title).font(.title).fontWeight(.semibold).foregroundColor(.white)
                        Spacer()
                        Button(action: {
                            openLink(link: post.url)
                        }) {
                            Text(NSLocalizedString("see_post", comment: "See Post")).padding(.horizontal).padding(.vertical, Constants.buttonVertical)
                        }.background(Capsule().fill(.white))
                    }.padding(.horizontal, Constants.horizontalPadding).padding(.vertical).background(Rectangle().fill(Color.gray.opacity(0.9))).frame(width: geometry.size.width)
                }
            }.frame(width: geometry.size.width)
        }
    }
    
    func openLink(link: String) {
        guard let url = URL(string: link) else {
            // Handle Error
            return
        }
        UIApplication.shared.open(url)
    }
}

struct SocialPostDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SocialPostDetailsView(post: SocialPost(albumId: 1, id: 1, title: "Test", url: "Test", thumbnailUrl: "Test"))
    }
}
