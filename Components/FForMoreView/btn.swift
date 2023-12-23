//
//  btn.swift
//  CommunityCloud
//
//  Created by GGS-BKS on 21/09/23.
//

import SwiftUI

struct btn: View {
    @State var No : String
    @State var Name : String
    @State var Thubnail : String
    var body: some View {
    
        VStack(alignment: .leading,spacing: 0){
            HStack{
                Text(No)
                    .padding(.leading,70)
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
                .font(.caption2)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .padding(.top,10)
                .padding(.leading,4)
            
            
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 25).fill(.white).shadow(color:.black.opacity(0.1),radius: 6,y:4))
    }
}

struct btn_Previews: PreviewProvider {
    static var previews: some View {
        btn(No: "2", Name: "Meeting Room", Thubnail: "message.and.waveform.fill")
    }
}
