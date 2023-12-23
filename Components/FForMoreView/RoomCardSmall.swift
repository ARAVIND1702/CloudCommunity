//
//  RoomCardSmall.swift
//  CommunityCloud
//
//  Created by GGS-BKS on 22/09/23.
//

import SwiftUI

struct RoomCardSmall: View,Identifiable {
    var id = UUID()

    @State var RoomName : String = ""
    @State var ImageName : String = ""
    var body: some View {
        ZStack(alignment:.center){
                   Image(ImageName) // Replace "Munich" with the name of your image asset
                       .resizable()
                       .aspectRatio(contentMode: .fill)
                       .frame(width: 180, height: 190) // Adjust the size as needed
                       .clipShape(RoundedRectangle(cornerRadius: 25))
                   
            ZStack {
                VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
                    .modifier(TopCornersModifier(radius: 25))
                    .frame(width: 180, height: 80)
               
                HStack{
                    VStack(alignment: .leading,spacing: 10){
                        Text(RoomName)
                            .font(.body)
                            .fontWeight(.medium)
                        HStack{
                            Text("4 pax")
                                .font(.footnote)
                                
                            //Image(systemName: "tv").font(.body)
                            //Image(systemName: "video").font(.body)
                        }
                    }
                    Spacer()
                    Image(systemName: "heart")
                        .font(.body)
                }
                .foregroundColor(.white)
                .padding()
                .frame(width: 180)
            }
            .offset(y:-55)
                
            
               }
    }
}

//struct RoomCardSmall_Previews: PreviewProvider {
//    static var previews: some View {
//        RoomCardSmall()
//    }
//}
