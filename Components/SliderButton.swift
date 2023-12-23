//
//  SliderButton.swift
//  CommunityCloud
//
//  Created by GGS-BKS on 27/09/23.
//

import SwiftUI

struct SliderButton: View {
    @State var Toggle = false
    var body: some View {
        VStack{
            Button{
                withAnimation(.easeInOut(duration: 0.45)){
                    Toggle = !Toggle
                }

            }label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width:55,height: 220)
                        .rotationEffect(.degrees(90))
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.white)
                        .frame(width:45,height: 100)
                        .rotationEffect(.degrees(90))
                        .offset(x: Toggle ? -55 : 55)

//                    Circle()
//                       .fill(.white)
//                       .frame(width:26)

                        
                }
            }
        }
    }
}

struct SliderButton_Previews: PreviewProvider {
    static var previews: some View {
        SliderButton()
    }
}
