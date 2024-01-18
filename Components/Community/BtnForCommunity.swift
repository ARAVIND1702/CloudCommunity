//
//  BtnForCommunity.swift
//  CommunityCloud
//
//  Created by ARAVIND RM on 07/01/24.
//

import SwiftUI

struct BtnForCommunity: View {
    @State var No : String
    @State var Name : String
    @State var Thubnail : String
    
    var body: some View {
        VStack(alignment: .leading,spacing: 0){
            HStack{
                Text(No)
                    .padding(.leading,65)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Image(systemName: Thubnail)
                .padding(15)
                .foregroundColor(.white)
                .font(.callout)
                .background(Circle().fill(Color.accentColor))
                .clipShape(Circle())
                .shadow(radius: 4,y:4)
            Text(Name)
                .font(.caption)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .padding(.top,10)
                .padding(.leading,4)
            
            
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 25).fill(.white).shadow(color:.black.opacity(0.1),radius: 6,y:4))
    }
}

#Preview {
    BtnForCommunity(No: "24", Name: "Meeting Room", Thubnail: "message.and.waveform.fill")
}
