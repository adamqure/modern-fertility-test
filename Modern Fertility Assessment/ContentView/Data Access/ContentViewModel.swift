//
//  ContentViewModel.swift
//  Modern Fertility Assessment
//
//  Created by Adam Ure on 2/2/22.
//

import Foundation

class ContentViewModel: ObservableObject {
    private struct Constants {
        static let url = "https://jsonplaceholder.typicode.com/album/1/photos"
    }
    
    /// Boolean to trigger a details cover sheet to be displayed
    @Published var shouldShowDetails = false
    
    
    @Published var selectedPost: SocialPost? = nil {
        didSet {
            guard selectedPost != nil else {
                shouldShowDetails = false
                return
            }
            shouldShowDetails = true
        }
    }
    
    /// List of posts to be displayed to the user
    @Published var posts: [SocialPost] = []

    private let networkProvider: RemoteNetworkProvider
    
    init(networkProvider: RemoteNetworkProvider) {
        self.networkProvider = networkProvider
        fetchSocialPosts()
    }

    func fetchSocialPosts() {
        Task {
            let networkResponse = await networkProvider.performRequest(at: Constants.url, .get, nil)
            switch networkResponse {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let postList = try decoder.decode([SocialPost].self, from: data ?? Data())
                    await MainActor.run {
                        posts = postList
                    }
                } catch {
                    // Handle Error
                }
            case .failure(_):
                // Handle Error
                break
            }
            
        }
    }
}
