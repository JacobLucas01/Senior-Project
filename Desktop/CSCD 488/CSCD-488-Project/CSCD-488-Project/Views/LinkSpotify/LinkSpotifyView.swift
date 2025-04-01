//
//  LinkSpotifyView.swift
//  CSCD-488-Project
//
//  Created by Jacob Lucas on 3/1/25.
//

import SwiftUI

struct LinkSpotifyView: View {
    @StateObject private var viewModel = LinkSpotifyViewModel()
    var body: some View {
        ZStack {
            Color.theme.black.ignoresSafeArea()
            VStack {
                heading
                
                Spacer()
                HStack {
                    PodcastCardPreview(card: CarouselCard(id: 0, image: "joe_rogan", title: "Joe Rogan", publisher: "Joe Rogan"))
                    PodcastCardPreview(card: CarouselCard(id: 1, image: "talk_tuah", title: "Talk Tuah", publisher: "Betr"))
                        .scaleEffect(1.4)
                        .padding(.horizontal, 45)
                    PodcastCardPreview(card: CarouselCard(id: 2, image: "ted_talks", title: "TED Talks Daily", publisher: "TED"))
                }
                
                Spacer()
                
                Button {
                    linkSpotify()
                } label: {
                    spotifyButtonDesign
                }
                .padding()
                .buttonStyle(ButtonScaleEffect())
                .onOpenURL { url in
                    viewModel.handleCallbackURL(url)
                }
                .onChange(of: viewModel.accessToken) { (_, newToken) in
                    if let token = newToken {
                        viewModel.fetchUserProfile(token: token)
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width)
            .padding(.bottom, 8)
        }
    }
    
    private func linkSpotify() {
        let url = "https://cscd-488-project.glitch.me/login"
        if let url = URL(string: url) {
            UIApplication.shared.open(url)
        }
    }
}

extension LinkSpotifyView {
    private var heading: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Connect Your")
                    .font(.system(size: 36, weight: .bold))
                HStack(spacing: 10) {
                    Image("spotify_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .padding(4)
                        .background {
                            Circle()
                                .stroke(lineWidth: 1)
                                .foregroundStyle(.white.opacity(0.2))
                        }
                    Text("Spotify ")
                        .font(.system(size: 36, weight: .bold))
                }
                
                Text("Connect your Spotify account to generate, save, and play playlists based on your mood.")
                    .font(.system(size: 14))
                    .padding(.trailing)
                    .padding(.top, 8)
                    .lineSpacing(3)
            }
            Spacer(minLength: 0)
        }
        .padding(.horizontal)
        .foregroundStyle(.white)
    }
    
    private var spotifyButtonDesign: some View {
        HStack(spacing: 12) {
            Spacer(minLength: 0)
            Image("spotify_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            Text("Connect Spotify")
                .font(.system(size: 22, weight: .medium))
                .foregroundStyle(Color.theme.spotifyGreen)
            Spacer(minLength: 0)
        }
        .padding()
        .background {
            Capsule()
                .foregroundStyle(.white.opacity(0.1))
        }
    }
}

#Preview {
    LinkSpotifyView()
}
