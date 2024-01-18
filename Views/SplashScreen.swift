//
//  SplashScreen.swift
//  CommunityCloud
//
//  Created by Shwetha on 24/12/23.
//

import SwiftUI

struct SplashScreen: View {
    @State var isActive: Bool = false
    @AppStorage("hide") var hide: Bool = false

        var body: some View {
            ZStack {
                if self.isActive {
                    LoginView()
                } else {
                    ZStack{
                        Color(red: 0.3411764705882353, green: 0.396078431372549, blue: 0.9490196078431372)
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    }.ignoresSafeArea()
                    }
                    
            }
                
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }

}

#Preview {
    SplashScreen()
}
