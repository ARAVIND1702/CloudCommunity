//
//  RoundedButtons.swift
//  CommunityCloud
//
//  Created by GGS-BKS on 04/10/23.
//

import SwiftUI

struct RoundedButtons: View {
    @State private var isExpanded = false

    var body: some View {
        VStack{
            Spacer()

            HStack{
                Spacer()
                Button{
                    withAnimation(.easeInOut(duration: 1)){
                        isExpanded = !isExpanded
                        
                    }
                }label: {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(red: 0.973, green: 0.972, blue: 0.981))
                        .frame(width: 30 ,height: 30)
                        .overlay{
                            Image(systemName: "info.circle.fill")
                            //                                .offset(y:isExpanded ? 0 : -48)
                            
                            //
                            //
                            //                                Text("Auto mode detects the motions and steps to navigate automatically")
                            //                                    .foregroundColor(.black)
                            //                                    .opacity(isExpanded ? 0 : 1)
                            //                                    .padding()
                        }
                }
            }
            .offset(y:50)
            .padding()
        
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 0.973, green: 0.972, blue: 0.981))
                .offset(y: isExpanded ? 0 : 600)
                .frame(width:320,height: 170)
                .overlay{
                    VStack{
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.accentColor)
                         .offset(y: isExpanded ? 0 : 600)
                         Text("Auto mode detects the motions and steps to navigate automatically")
                            .multilineTextAlignment(.center)
                               .foregroundColor(.black)
                               .offset(y: isExpanded ? 0 : 600)
                               .opacity(isExpanded ? 1 : 0)
                               .padding()
                    }
                   
                }
            Spacer()
        }
        .background(isExpanded ? .black.opacity(0.4) : .black.opacity(0))
        .ignoresSafeArea()
        .onTapGesture {
            if isExpanded {
                withAnimation(.easeInOut(duration: 1)){
                    isExpanded = false
                    
                }            }
        }
    }
}




struct RoundedButtons_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButtons()
    }
}
