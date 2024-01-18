//
//  CommunityRoomView.swift
//  CommunityCloud
//
//  Created by ARAVIND RM on 06/01/24.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct CommunityRoomView: View {
    @Environment(\.presentationMode) var presentationMode // for back button
    //for showing gallery
    @State private var showImagePicker: Bool = false
    @State private var photoItem: PhotosPickerItem?
    @State private var createNewPost : Bool = false
    
    //post for community
    var Community : String
    @State private var fetchedPosts: [Post] = []
    @State private var recentsPosts: [Post] = []
    
    @State var Icon : String = ""
    
    // Dedicated to this page
    @State private var message: String = ""
    @FocusState private var isTextFieldFocused: Bool
    
    //global for the hiding the bar
    @AppStorage("hide") var hide: Bool = false
    
    
    var body: some View {
        NavigationStack{
            VStack {
                HStack{
                    Button {
                        presentationMode.wrappedValue.dismiss()
                        
                    } label: {
                        Image("nav")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24,height: 24)
                    }
                    .padding(.leading)
                    Image(systemName: Icon)
                        .padding(12)
                        .foregroundColor(.white)
                        .font(.callout)
                        .background(Circle().fill(Color.accentColor))
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.3), radius: 4,y:4)
                        .offset(y:-4)
                    
                    Text(Community.replacingOccurrences(of: "_", with: " "))
                        .font(.callout)
                        .offset(y:-4)
                    
                    
                    Spacer()
                    
                    Button(action: {
                        createNewPost = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                    }
                    
                    
                    .padding(.horizontal)
                }
                
                .ignoresSafeArea()
                .frame(height: 50)
                .background(.white.shadow(.drop(radius: 10)))
                Spacer()
                
                ReusablePostsView(basedonCommunity: true, Community : Community ,posts: $recentsPosts)
                
                // Responsive keyboard like whatsup
                //                HStack(alignment: .bottom) {
                //                    HStack(spacing: 8) {
                //                        withAnimation(.easeInOut) {
                //                            TextField("", text: $message, axis: .vertical)
                //                                .placeholder(when: message.isEmpty) {
                //                                    Text("Message...")
                //                                        .foregroundColor(.secondary)
                //                                }
                //                            // Add maximum vertical visible line limit
                //                                .lineLimit(...7)
                //                        }
                //                    }
                //                    .padding(.vertical, 8)
                //                    .padding(.horizontal, 12)
                //                    .background(.white)
                //                    .cornerRadius(10)
                //
                //                    // Send button
                //                    if message != "" {
                //                        Button {
                //                        } label: {
                //                            Image(systemName: "arrow.up.circle.fill")
                //                                .font(.largeTitle)
                //                        }
                //                    } else {
                //                        Button {
                //                            withAnimation(.easeInOut(duration: 0.35)){
                //                                showImagePicker.toggle()
                //
                //
                //
                //                            }                        } label: {
                //                            Image(systemName: "photo.circle.fill")
                //                                .font(.largeTitle)
                //                                .foregroundColor(Color(.systemGray))
                //                        }
                //                    }
                //                }
                //                .padding(.leading , 14)
                //                .padding(.trailing, 10)
                //                .padding(.vertical, 7)
                //                .frame(maxWidth: .infinity)
                //                .frame(minHeight: 55)
                //                .background(.ultraThinMaterial)
                //                .ignoresSafeArea()
                //                .animation(.easeInOut(duration: 0.3), value: message)
            }
            .background(Color(red: 0.973, green: 0.972, blue: 0.981))
            .fullScreenCover(isPresented: $createNewPost){
                CreatePost(Community: Community, onPost:{ post in
                    recentsPosts.insert(post, at: 0)
                })
            }
            .onAppear{
                withAnimation(.easeInOut(duration: 1)){
                    //  hide = true
                    setIcon()
                }
            }
            //.toolbar(.hidden, for: .tabBar)
            
            .onDisappear{
                withAnimation(.easeInOut(duration: 1)){
                    // hide = false
                }
            }
        }
    }
    
    
    func setIcon() {
        switch Community {
        case "Open_Source":
            Icon = "apple.terminal"
        case "Podcasts":
            Icon = "message.and.waveform.fill"
        case "Riders_Club":
            Icon = "road.lanes"
        case "Cinephile":
            Icon = "popcorn.fill"
        case "Audiophile":
            Icon = "beats.headphones"
        case "Sport_Club":
            Icon = "figure.table.tennis"
        default:
            Icon = "default.icon" // Set a default icon or handle the case accordingly
        }
    }
}
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
    
#Preview {
    CommunityRoomView(Community: "Open_Source")

}

