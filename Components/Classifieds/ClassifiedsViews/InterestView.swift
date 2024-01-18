//
//  InterestView.swift
//  CommunityCloud
//
//  Created by ARAVIND RM on 11/01/24.
//

import SwiftUI

struct InterestView: View {
    @State var Show = false

    var body: some View {
        VStack {
            ClassifiedReqBridge()
            Spacer()
            
            Button{
                
                Show = true
                
                }label: {
                Text("Create New Ad")
                    .lineLimit(1)
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 120)
                    .padding(.vertical,19)
                    .padding(.horizontal,100)
                    
                
                    .background(
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(Color(red: 0.339, green: 0.396, blue: 0.95))
                            .shadow(color:.black.opacity(0.1) ,radius: 1 ,y:2)
                        
                    )
                }
    }.sheet(isPresented: $Show){
        CreateClassifiedView(onPublish: {_ in}, Show: $Show)
    }
        }
    }


struct InterestView_Previews: PreviewProvider {
    static var previews: some View {
        InterestView()
    }
}
