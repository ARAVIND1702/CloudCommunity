//
//  FeedView.swift
//  CommunityCloud
//
//  Created by GGS-BKS on 16/08/23.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
struct FeedView: View {
    @State private var myprofile:User?
    @State private var recentsPosts: [Post] = []
    @State private var createNewPost : Bool = false
    @State var postTextForTrigger: String = ""

    @FocusState private var isViewVisible : Bool
    @State  var isMenuOn : Bool = false
    @State  var isWish : Bool = false

    @State var isShaking : Bool =  true
    @AppStorage("hide") var hide: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var usernamestored: String = ""
    
    
    var body: some View {
        NavigationStack{
        VStack{
            HStack(spacing:2){
                WebImage(url:profileURL).placeholder{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .foregroundColor(Color(red: 0.339, green: 0.396, blue: 0.95))
                }
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60,height: 60)
                .clipShape(Circle())
                Spacer()
                VStack{
                    TextField("What's happening?", text: $postTextForTrigger)
                                    .padding(.horizontal)
                                    .padding(.vertical, 9)
                                    .focused($isViewVisible)
                                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                                        if isViewVisible {
                                                                createNewPost = true
                                                                isViewVisible=false
                                                                }
                                        
                                    }
                                    
//                                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
//                                        createNewPost = false
            //                                    }
                 


                }
                    .background(RoundedRectangle(cornerRadius: 10.0).fill(.white))
                    .shadow(color:.black.opacity(0.1),radius: 3,y:4)

            }
            .padding()
            Spacer()
            ReusablePostsView(posts: $recentsPosts)
        }
        .onAppear{
         hide = false
        }
        .fullScreenCover(isPresented: $createNewPost){
            CreatePost{ post in
                recentsPosts.insert(post, at: 0)
            }
        }
      .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                HStack{
                    Text("Welcome,")
                    Text(usernamestored)
                        .fontWeight(.light)
                }
                
            }
            ToolbarItem(placement: .navigationBarTrailing){
                HStack{
                    NavigationLink{
                        SearchView()
                    }label: {
                        
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                                .padding(.horizontal)
                                .tint(.black)
                           
                        
                        
                    }
                    Image(systemName: "bell.fill")
                        .font(.system(size: 15))

                    Text("5") // Replace "5" with the actual number of notifications
                            .foregroundColor(.white)
                            .font(.caption2)
                            .padding(3)
                            .background(Circle().fill(Color(red: 0.339, green: 0.396, blue: 0.95)
))
                            .offset(x: -16, y: -8)
                    Button{
                        withAnimation(.easeInOut(duration: 0.45)){
                            isMenuOn = !isMenuOn
                        }
                    }label: {
                        ZStack {
                          Circle()
                                .fill(Color(red: 0.3411764705882353, green: 0.396078431372549, blue: 0.9490196078431372))
                                .frame(width: isMenuOn ? 30 : 0, height:  isMenuOn ? 30 : 0)
                            Image(systemName:"ellipsis.circle")
                               .rotationEffect(.degrees(isMenuOn ? 90 : 0))
                              .font(.system(size: 15))
                              .fontWeight(.medium)
                              .foregroundStyle(isMenuOn ? .white : .black)

                              .shadow(radius: 8)
                    }
                    }
                         
                    
                    
                }
            }
            
        }
        .overlay{
            if isMenuOn{
            
                        VStack(spacing:15){
                        Spacer()
                            HStack{
                                Spacer()
                                
                                NavigationLink(destination: MoreView()) {
                                    HStack {
                                        Text("Wayfinder")
                                            .foregroundStyle(.white)
                                            .font(.callout)
                                            .fontDesign(.rounded)
                                            .fontWeight(.light)
                                        Circle()
                                            .frame(width: 30, height: 30) // Adjust the size as needed
                                            .overlay(
                                                Image(systemName: "map")
                                                    .font(.caption)
                                                    .foregroundStyle(.white)
                                                    .shadow(radius: 8)
                                        )
                                    }
                                }

                                    
                                
                                
                            }.padding(.horizontal)
                            HStack{
                                Spacer()
                                
                                NavigationLink(destination: ChatView()) {
                                    HStack {
                                        Text("Office Buddy")
                                            .foregroundStyle(.white)
                                            .font(.callout)
                                            .fontDesign(.rounded)
                                            .fontWeight(.light)
                                        Circle()
                                            .frame(width: 30, height: 30) // Adjust the size as needed
                                            .overlay(
                                                Image(systemName: "message.fill")
                                                    .font(.caption)
                                                    .foregroundStyle(.white)
                                                    .shadow(radius: 8)
                                        )
                                    }
                                }

                                    
                                
                                
                            }.padding(.horizontal)
                            HStack{
                                Spacer()
                                
                                NavigationLink(destination: Events()) {
                                    HStack {
                                        Text("Events")
                                            .foregroundStyle(.white)
                                            .font(.callout)
                                            .fontDesign(.rounded)
                                            .fontWeight(.light)
                                        Circle()
                                            .frame(width: 30, height: 30) // Adjust the size as needed
                                            .overlay(
                                                Image(systemName: "calendar")
                                                    .font(.caption)
                                                    .foregroundStyle(.white)
                                                    .shadow(radius: 8)
                                        )
                                    }
                                }

                                    
                                
                                
                            }.padding(.horizontal)
                            HStack{
                                Spacer()
                                
                                Button{ withAnimation(.easeInOut(duration: 0.45)){
                                    isWish = !isWish
                                }
                                    
                                }label:{
                                    HStack {
                                        VStack(spacing:5){
                                            HStack{
                                                Text("Vijay's")
                                                    .font(.caption)
                                                    .fontWeight(.semibold)
                                                    .foregroundStyle(.black)
                                                Text("Birthday")
                                                    .font(.caption)
//                                                    .foregroundStyle(.accentColor)


                                            }
                                            HStack{
                                                Text("Guhan's")
                                                    .font(.caption)
                                                    .fontWeight(.semibold)
                                                    .foregroundStyle(.black)
                                                Text("Work Anniversary")
                                                    .font(.caption)
                                                   // .foregroundStyle(.accentColor)


                                            }
                                        }   
                                        .padding()                                    .background(RoundedRectangle(cornerRadius: 5, style: .continuous).fill(Color(red: 0.973, green: 0.972, blue: 0.981)).opacity(0.9))
                                        Text("Wishes")
                                            .foregroundStyle(.white)
                                            .font(.callout)
                                            .fontDesign(.rounded)
                                            .fontWeight(.light)
                                        Image("gift")
                                        .resizable()
                                        .frame(width: 28, height: 28)
                                          .foregroundColor(.white)
                                                                .shadow(radius: 8)
                                                                .rotationEffect(isShaking ? Angle(degrees: -10) : Angle(degrees: 0))
                                                                .animation(
                                                                    Animation.easeInOut(duration: 0.3)
                                                                        .repeatCount(500, autoreverses: true)
                                                                        
                                                                )
                                        
                                    }
                                }

                                    
                                
                                
                            }
                            .onAppear {
                                withAnimation {
                                    isShaking.toggle()
                                }}
                            .padding(.horizontal)

                            Spacer()
                            Spacer()
                        }
                
                        .ignoresSafeArea(.all)
                        .background(Color.black.opacity(0.6))
                        //.mask(Color.black.opacity(0.3)) // Adjust the opacity here
            
            }else{ }
        }
        .background(Color(red: 0.973, green: 0.972, blue: 0.981))
        
           
        
        }
    }
 
   
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
