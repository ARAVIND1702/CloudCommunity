//
//  SliderButton.swift
//  CommunityCloud
//
//  Created by GGS-BKS on 27/09/23.
//

import SwiftUI

struct SliderButton: View {
   @Binding var Toggle : Bool
   // @State var Toggle = false

    var body: some View {
            Button{
                withAnimation(.easeInOut(duration: 0.45)){
                    Toggle = !Toggle
                }

            }label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 30)
                        .frame(width:35,height: 120)
                        .rotationEffect(.degrees(90))
                        .overlay{
                            Text(Toggle ? "Manual" : "Auto")
                                .frame(width: 100)
                                .foregroundColor(.white)
                                .font(.caption2)
                                .offset(x:Toggle ? 30 : -30)
                        }
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.white)
                        .frame(width:25,height: 60)
                        .rotationEffect(.degrees(90))
                        .offset(x: Toggle ? -25 : 25)
                        .overlay{
                            Text(Toggle ? "Auto" : "Manual")
                                .frame(width: 100)
                                .font(.caption2)
                                .offset(x: Toggle ? -25 : 25)
                        }
                        .shadow(color:.black.opacity(0.2),radius: 4)

//                    Circle()
//                       .fill(.white)
//                       .frame(width:26)

                        
                }.frame(width:200,height: 100)
            }.frame(width:200,height: 100)
        
    }
}

//struct SliderButton_Previews: PreviewProvider {
//    static var previews: some View {
//        SliderButton()
//    }
//}
