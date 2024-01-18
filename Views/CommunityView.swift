//
//  CommunityView.swift
//  CommunityCloud
//
//  Created by ARAVIND RM on 06/01/24.
//

import SwiftUI

struct CommunityView: View {
    @State private var isActive = 2
    @State private var searchEvent = ""

    
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var usernamestored: String = ""
    var body: some View {
        NavigationStack{
            
                VStack(alignment: .leading){
                    HStack{
                        Text("Communities")
                            .fontWeight(.semibold)
                            .font(.title2)
                        Spacer()
                    }.padding(.top,10)
                        .padding(.horizontal)
                    Text("Explore and find your peoples in B/S/H enivironment and grow together")
                        .frame( height: 70)
                        .padding(.horizontal)
                        .foregroundColor(.gray)
                        .font(.footnote)
                    /* Scroll category add when neeeded
                    ScrollView(.horizontal,showsIndicators: false){
                        HStack(spacing: 18){
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.45)){
                                    isActive = 2
                                }
                            }) {
                                Text("Floor 2")
                                    .foregroundColor(isActive==2 ? .white : .accentColor)
                                    .padding(.horizontal,24)
                                    .padding(.vertical,8)
                                    .background(
                                        Group {
                                            if isActive == 2 {
                                                RoundedRectangle(cornerRadius: 40)
                                            } else {
                                                RoundedRectangle(cornerRadius: 40)
                                                    .stroke(Color.accentColor, lineWidth: 1)
                                                    .shadow(color: .black.opacity(0.8), radius: 4, y: 4)
                                            }
                                        }
                                    )
                                
                            }
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.45)){
                                    isActive = 3
                                }                        }) {
                                    Text("Floor 3")
                                        .foregroundColor(isActive==3 ? .white : .accentColor)
                                        .padding(.horizontal,24)
                                        .padding(.vertical,8)
                                        .background(
                                            Group {
                                                if isActive == 3 {
                                                    RoundedRectangle(cornerRadius: 40)
                                                } else {
                                                    RoundedRectangle(cornerRadius: 40)
                                                        .stroke(Color.accentColor, lineWidth: 1)
                                                        .shadow(color: .black.opacity(0.8), radius: 4, y: 4)
                                                }
                                            }
                                        )
                                    
                                }
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.45)){
                                    isActive = 5
                                }                        }) {
                                    Text("Floor 5")
                                        .foregroundColor(isActive==5 ? .white : .accentColor)
                                        .padding(.horizontal,24)
                                        .padding(.vertical,8)
                                        .background(
                                            Group {
                                                if isActive == 5 {
                                                    RoundedRectangle(cornerRadius: 40)
                                                } else {
                                                    RoundedRectangle(cornerRadius: 40)
                                                        .stroke(Color.accentColor, lineWidth: 1)
                                                        .shadow(color: .black.opacity(0.8), radius: 4, y: 4)
                                                }
                                            }
                                        )
                                    
                                }
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.45)){
                                    isActive = 0
                                }                        }) {
                                    Text("Parking")
                                        .foregroundColor(isActive==0 ? .white : .accentColor)
                                        .padding(.horizontal,24)
                                        .padding(.vertical,8)
                                        .background(
                                            Group {
                                                if isActive == 0 {
                                                    RoundedRectangle(cornerRadius: 40)
                                                } else {
                                                    RoundedRectangle(cornerRadius: 40)
                                                        .stroke(Color.accentColor, lineWidth: 1)
                                                        .shadow(color: .black.opacity(0.8), radius: 4, y: 4)
                                                }
                                            }
                                        )
                                    
                                }
                        }
                        .padding()
                    
                    }
                     */
                    ////////////////////////////////////////////////////////////Seacrh
                   /* RoundedRectangle(cornerRadius: 10, style: .circular)
                        .foregroundColor(.white) // Set the background color
                        .frame( height: 42.09) // Adjust the height of the RoundedRectangle
                        .shadow(color:.black.opacity(0.1),radius: 3,y:4)
                        .overlay(HStack{
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray.opacity(0.4))
                                .font(.title3)
                                .fontWeight(.semibold)
                                .padding(.leading)
                            TextField("Serach for event",text: $searchEvent)
                                .foregroundColor(.black)
                            
                        })
                        .padding(.horizontal)
                    */
                    ////////////////////////////////////////////////////////////Seacrh
                    VStack(alignment:.leading){
                        Text("Clubs").padding(.horizontal)
                        HStack{
                            NavigationLink{
                                CommunityRoomView( Community: "Open_Source").navigationBarBackButtonHidden(true)
                            }label: {
                                BtnForCommunity(No: "98", Name: "Open Sources", Thubnail: "apple.terminal")
                            }
                            NavigationLink{
                                CommunityRoomView( Community: "Podcasts").navigationBarBackButtonHidden(true)
                            }label: {
                                BtnForCommunity(No: "45", Name: "Podcasts", Thubnail: "message.and.waveform.fill")
                            }
                            NavigationLink{
                                CommunityRoomView( Community: "Riders_Club").navigationBarBackButtonHidden(true)
                            }label: {
                                BtnForCommunity(No: "34", Name: "Riders Club", Thubnail: "road.lanes")
                            }
                        }.padding(.horizontal)
                        HStack{
                            NavigationLink{
                                CommunityRoomView( Community: "Cinephile").navigationBarBackButtonHidden(true)
                            }label: {
                                BtnForCommunity(No: "54", Name: "Cinephile", Thubnail: "popcorn.fill")
                            }
                            NavigationLink{
                                CommunityRoomView(Community: "Audiophile").navigationBarBackButtonHidden(true)
                            }label: {
                                BtnForCommunity(No: "45", Name: "Audhiophile", Thubnail: "beats.headphones")
                            }
                            NavigationLink{
                                CommunityRoomView(Community: "Sports_Club").navigationBarBackButtonHidden(true)
                            }label: {
                                BtnForCommunity(No: "84", Name: "Sport Club", Thubnail: "figure.table.tennis")
                            }
                           
                        }.padding(.horizontal)
                        HStack{
                            BtnForCommunity(No: "", Name: "New Interest", Thubnail: "plus")
                           
                           
                        }.padding(.horizontal).padding(.bottom)
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()

                }
//                .toolbar{
//                    ToolbarItem(placement: .navigationBarLeading){
//                        HStack{
//                            Text("Welcome,")
//                            Text(usernamestored)
//                                .fontWeight(.bold)
//                        }
//
//                    }
//                    ToolbarItem(placement: .navigationBarTrailing){
//                        HStack{
//                            NavigationLink{
//                                SearchView()
//                            }label: {
//                                Image(systemName: "magnifyingglass")
//                                    .font(.system(size: 15))
//                                    .fontWeight(.bold)
//                                    .padding(.horizontal)
//                                    .tint(.black)
//                            }
//                            Image(systemName: "bell.fill")
//                                .font(.system(size: 15))
//
//                            Text("5") // Replace "5" with the actual number of notifications
//                                .foregroundColor(.white)
//                                .font(.caption2)
//                                .padding(3)
//                                .background(Circle().fill(Color(red: 0.339, green: 0.396, blue: 0.95)
//                                                         ))
//                                .offset(x: -16, y: -8)
//                        }
//                    }
//                }
                
                
        }.navigationTitle(Text("Communities"))
    }
}

#Preview {
    CommunityView()
}
