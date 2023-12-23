//
//  ExtenededRoomView.swift
//  CommunityCloud
//
//  Created by GGS-BKS on 25/09/23.
//

import SwiftUI

struct ExtenededRoomView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var isSmall = false
    @State var ShowPopUp = false
    @State var RoomName = ""
    @State var ImageName = "Munich"
    var body: some View {
        VStack{
            ZStack{
                Image(ImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(50)
                    .shadow(radius: 4)
                HStack{
                    Button {
                        presentationMode.wrappedValue.dismiss()

                    } label: {
                        Image(systemName: "chevron.backward")
                            .font(.headline)
                            .foregroundColor(.black)
                    }
                    
                    .offset(y: isSmall ? -110 : -150)
                    .padding()
                    Spacer()
                }
                    
            }.offset(y:isSmall ? -10 : -50)
            VStack{

                HStack{
                    VStack(alignment: .leading,spacing: 10){
                        Text(RoomName)
                            .font(.title)
                        Text("12px")
                    }
                    
                    Spacer()
                    Image(systemName: "heart")
                        .font(.title)
                }.padding(.horizontal)
                HStack{
                    Button{
                        
                    }label: {
                        HStack{
                            Image(systemName: "tv")
                                .font(.subheadline)
                            Text("Television")
                                .font(.caption)
                        }
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .padding(.vertical,8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.gray.opacity(0.2))
                        )
                    }
                    Button{
                        
                    }label: {
                        HStack{
                            Image(systemName: "video.badge.plus")
                                .font(.subheadline)
                            Text("Video Conferencing")
                                .font(.caption)
                        }
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .padding(.vertical,8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.gray.opacity(0.2))
                        )
                    }
                    Spacer()
                }.padding(.horizontal)
                Text("Warsaw meeting room is a space usually set aside for people to get together, often informally to hold meetings, for issues to be discussed, priorities set and decisions made.")
                    .font(.footnote)
                    .padding()
                if(isSmall){
                    Spacer()
                    Spacer()
                }
                
                Button{
                    withAnimation(.easeInOut(duration: 0.45)){
                        ShowPopUp = !ShowPopUp
                    }
                } label: { RoundedRectangle(cornerRadius: 12, style: .circular)
                        .fill()
                        .frame(height: 60)
                        .overlay(
                            Text("Start Wayfinder")
                                .foregroundColor(.white)
                                .fontWeight(.medium)
                            
                        )
                        .padding(.horizontal, 24)
                    
                    
                }
                if(isSmall){
                    Spacer()
                    Spacer()
                }

            }.offset(y:isSmall ? 0 : -60)
            
        }
        .overlay{
            
            ZStack{
                
                PopUpForWayFinder(ShowPopUp: $ShowPopUp,Destination:RoomName)
                    .offset(y: ShowPopUp ? 0 : 800)
            }
            .frame(maxHeight: .infinity)
            .background(ShowPopUp ? .black.opacity(0.2) : .black.opacity(0) )
        
        }
        .ignoresSafeArea()
    }
}

struct ExtenededRoomView_Previews: PreviewProvider {
    static var previews: some View {
        ExtenededRoomView()
    }
}
