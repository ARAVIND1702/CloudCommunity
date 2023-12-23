//
//  RoomCard.swift
//  CommunityCloud
//
//  Created by GGS-BKS on 22/09/23.
//

import SwiftUI

struct RoomView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var Cancelfilter = false
    @State var left: [RoomCards] = [
        RoomCards(islarge: false, RoomName: "Singapore", ImageName: "Singapore"),
        RoomCards(islarge: true, RoomName: "London", ImageName: "London"),
        RoomCards(islarge:false,RoomName: "Warsaw", ImageName: "Warsaw"),
        RoomCards(islarge:true,RoomName: "Paris", ImageName: "Paris")
    ]
    
    @State var right: [RoomCards] = [
        RoomCards(islarge:true,RoomName:"Munich",ImageName: "Munich"),
        RoomCards(islarge:false,RoomName: "Istanbul",ImageName:"Istanbul"),
        RoomCards(islarge:true,RoomName: "Mumbai",ImageName:"Mumbai"),
        RoomCards(islarge:false,RoomName: "Dubai",ImageName:"Dubai")
    ]
    @State var leftTemp: [RoomCards] = []
    @State var rightTemp: [RoomCards] = []

    // Initialize the temporary copies with the original arrays
  

    func Sort(){
        withAnimation(.easeInOut(duration: 0.50)){
            leftTemp = left.sorted { $0.RoomName < $1.RoomName }
            rightTemp = right.sorted{ $0.RoomName < $1.RoomName }
            
        }
    Cancelfilter = true
    
    }
   


    var body: some View {
        NavigationStack{
            VStack(spacing: 0){
                HStack{
                    Button {
                        presentationMode.wrappedValue.dismiss()

                    } label: {
                        Image("nav")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24,height: 24)
                    }
                    .padding(.horizontal)
                    Spacer()
                    Text("Meeting Rooms - Floor")
                    Spacer()
                    Menu {
                        Button(action: {
                            Sort()
                        }) {
                            Text("Sort")
                        }
                        if Cancelfilter {
                            Button(role: .destructive) {
                                // Your action code goes here
                                withAnimation(.easeInOut(duration: 0.45)){
                                    leftTemp = left
                                    rightTemp = right
                                    
                                    Cancelfilter = false
                                }
                            } label: {
                                Label("Cancel", systemImage: "xmark.circle")
                            }
                        }

                   

                        
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .foregroundColor(.black)
                    }
                     
                    .padding(.horizontal)
                }
                
                .ignoresSafeArea()
                .frame(height: 50)
                .background(.white.shadow(.drop(radius: 10)))
                ScrollView(showsIndicators: false){
                    Spacer()
                    HStack{
                        VStack(spacing: 15){
//                            NavigationLink{
//                                ExtenededRoomView(RoomName: "Munich",ImageName:"Munich").navigationBarBackButtonHidden(true)
//                            }label: {
//                                RoomCards(RoomName:"Munich",ImageName: "Munich")
//
//                            }
//                            NavigationLink{
//                                ExtenededRoomView(isSmall:true,RoomName: "Istanbul",ImageName:"Istanbul").navigationBarBackButtonHidden(true)
//                            }label: {
//                                RoomCardSmall(RoomName: "Istanbul",ImageName:"Istanbul")
//
//                            }
//                            NavigationLink{
//                                ExtenededRoomView(RoomName: "Mumbai",ImageName:"Mumbai").navigationBarBackButtonHidden(true)
//                            }label: {
//                                RoomCards(RoomName: "Mumbai",ImageName:"Mumbai")
//
//                            }
//                            NavigationLink{
//                                ExtenededRoomView(isSmall:true,RoomName: "Dubai",ImageName:"Dubai").navigationBarBackButtonHidden(true)
//                            }label: {
//                                RoomCardSmall(RoomName: "Dubai",ImageName:"Dubai")
//
//                            }
                            ForEach(rightTemp) { room in
                                NavigationLink{
                                    ExtenededRoomView(isSmall:!room.islarge,RoomName:room.RoomName,ImageName: room.ImageName).navigationBarBackButtonHidden(true)
                                }label: {
                                    room
                                }
                                
                            }

                        }
                        VStack(spacing: 15){
                                   ForEach(leftTemp) { room in
                                       NavigationLink{
                                           ExtenededRoomView(isSmall:!room.islarge,RoomName:room.RoomName,ImageName: room.ImageName).navigationBarBackButtonHidden(true)
                                       }label: {
                                           room
                                       }
                                       
                                   }
//                            RoomCards(islarge:false,RoomName: "London",ImageName:"London")
//                            RoomCards(RoomName: "Paris",ImageName:"London")
//                            RoomCards(islarge:false,RoomName: "Singapore",ImageName:"Singapore")
//                            RoomCards(RoomName: "Warsaw",ImageName:"Warsaw")
//                            RoomCards(islarge:false,RoomName: "Paris",ImageName:"London")
//                            RoomCards(RoomName: "Paris",ImageName:"London")
                            
                        }
                    }
                }
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 0.45)){
                    leftTemp = left
                    rightTemp = right
                }
               
            }
            .background(Color(red: 0.973, green: 0.972, blue: 0.981))
        }
    }
}

struct RoomCard_Previews: PreviewProvider {
    static var previews: some View {
        RoomView()
    }
}
