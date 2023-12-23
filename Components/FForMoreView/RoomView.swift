//
//  RoomCard.swift
//  CommunityCloud
//
//  Created by GGS-BKS on 22/09/23.
//

import SwiftUI

struct RoomView: View {
    var body: some View {
        ScrollView(showsIndicators: false){
        HStack{
            VStack(spacing: 15){
                RoomCards(RoomName:"Munich",ImageName: "Munich")
                RoomCardSmall()
                RoomCards()
                RoomCardSmall()
                RoomCards()
                RoomCardSmall()
                RoomCards()
                RoomCardSmall()
            }
            VStack(spacing: 15){
                RoomCardSmall()
                RoomCards()
                RoomCardSmall()
                RoomCards()
                RoomCardSmall()
                RoomCards()
                RoomCardSmall()
                RoomCards()
            }
        }
    }
        
    }
}

struct RoomCard_Previews: PreviewProvider {
    static var previews: some View {
        RoomCard()
    }
}
