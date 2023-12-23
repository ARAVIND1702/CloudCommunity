//
//  PopUpForWayFinder.swift
//  CommunityCloud
//
//  Created by GGS-BKS on 27/09/23.
//

import SwiftUI
import AVKit
import AVFoundation

struct PopUpForWayFinder: View {
    @State var MeetingRooms = ["Budapest","Instagram","Telegram","Warsaw","Zurich","London"]
    @State var Current = ""
    @Binding var ShowPopUp : Bool
    @State var Destination = ""
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Spacer()
                    
                    Button{
                        withAnimation(.easeInOut(duration: 0.45)){
                            ShowPopUp = !ShowPopUp
                            
                        }
                    }label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.black)
                    }
                }.padding()
                RoundedRectangle(cornerRadius: 12, style: .circular)
                    .foregroundColor(.white)
                    .frame(height: 60)
                    .overlay(
                        HStack{
                            Text("Find :")
                                .foregroundColor(.gray.opacity(0.7))
                                .padding()
                            Spacer()
                            Picker("Budapest", selection:$Current) {
                                ForEach(MeetingRooms, id: \.self) { category in
                                    Text(category)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                    )
                    .shadow(color:.black.opacity(0.1) ,radius: 2 ,y:2)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 14)
                ZStack{
                    VideoPlayerWrapper(videoURL: Bundle.main.url(forResource: "Video", withExtension: "mp4")!)
                        .frame(width: 250, height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .frame(width: 300, height: 300)
                    Rectangle()
                        .fill(.white)
                        .frame(width: 70,height: 50)
                        .offset(x:80,y:90)
                }
                
                Text("Stand in front of the conference room and follow the paths.")
                    .font(.subheadline)
                    .padding()
                NavigationLink{
                    WayFinderView(Current: Current,Destination: Destination)
                    
                }label: {
                        HStack{
                            Text("Find a Way")
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                            
                            
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(.white)
                                .rotationEffect(.degrees(-45))
                                .offset(y:3)
                            
                            
                        }
                        .padding(.vertical,8)
                        .padding(.horizontal)
                        .background(
                            RoundedRectangle(cornerRadius: 20.0)
                                .fill(Color(red: 0.339, green: 0.396, blue: 0.95))
                                .shadow(color:.black.opacity(0.1) ,radius: 2 ,y:2)
                            
                            
                            // You can specify a fill color if desired
                            
                            
                            
                        )
                        
                        
                  
                }.padding()
                
                
                
            }
            .background(RoundedRectangle(cornerRadius: 30, style: .circular)
                .fill(.white)
                .shadow(color:.black.opacity(0.1),radius: 3,y:4))
            .padding(.horizontal)
            
        }
    }
}

//struct PopUpForWayFinder_Previews: PreviewProvider {
//    static var previews: some View {
//        PopUpForWayFinder()
//    }
//}

struct VideoPlayerWrapper: UIViewControllerRepresentable {
    let videoURL: URL

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.showsPlaybackControls = false // Hide controls
        player.play()

        
        // Loop the video when it ends
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { _ in
            player.seek(to: CMTime.zero)
            player.play()
        }
        
        // Seek the video when it reaches the 13th second
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: nil) { time in
            let thirteenSeconds = CMTime(seconds: 10, preferredTimescale: 1)
            if time >= thirteenSeconds {
                player.seek(to: CMTime.zero)
                player.play()
            }
        }
        
        return playerViewController
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // Nothing to update
    }
}
