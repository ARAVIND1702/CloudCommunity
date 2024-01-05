//
//  MoreView.swift
//  CommunityCloud
//
//  Created by GGS-BKS on 21/09/23.
//

import SwiftUI

struct MoreView: View {
    @State private var isActive = 2
    @State private var searchEvent = ""

    
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var usernamestored: String = ""
    
    var body: some View {
        NavigationStack{
            
                VStack(alignment: .leading){
                    HStack{
                        Text("")
                            .font(.title3)
                        Spacer()
                    }.padding(.top,10)
                        .padding(.horizontal)
                    Text("Explore your work space to get a better experience of \ncafeteria, meeting rooms, entry/exit points, play area,\nwork stations, etc...")
                        .frame( height: 70)
                        .padding(.horizontal)
                        .foregroundColor(.gray)
                        .font(.footnote)
                    
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
                    ////////////////////////////////////////////////////////////Seacrh
                    RoundedRectangle(cornerRadius: 10, style: .circular)
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
                    ////////////////////////////////////////////////////////////Seacrh
                    VStack(alignment:.leading){
                        Text("Amenties").padding(.horizontal)
                        HStack{
                            NavigationLink{
                                RoomView().navigationBarBackButtonHidden(true)
                            }label: {
                                btn(No: "9", Name: "Meeting Room", Thubnail: "message.and.waveform.fill")
                            }
                            btn(No: "1", Name: "Cafeteria", Thubnail: "cup.and.saucer")
                            
                            btn(No: "2", Name: "Washrooms", Thubnail: "toilet")
                        }.padding(.horizontal)
                        HStack{
                            btn(No: "6", Name: "Workspaces", Thubnail: "studentdesk")
                           
                            btn(No: "1", Name: "IT Support", Thubnail: "person.2.badge.gearshape.fill")
                            
                            btn(No: "2", Name: "Entry/Exit", Thubnail: "arrow.down.right.and.arrow.up.left")
                        }.padding(.horizontal)
                        HStack{
                            btn(No: "2", Name: "Play Area", Thubnail: "figure.table.tennis")
                           
                            btn(No: "5", Name: "Relax Zones", Thubnail: "tree")
                            
                            btn(No: "2", Name: "Medical Rooms", Thubnail: "cross.case.fill")
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
                
                
        }.navigationTitle(Text("Wayfinder"))
            
        }
    }


struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
    }
}
