//
//  Home.swift
//  CommunityCloud
//
//  Created by GGS-BKS on 14/08/23.
//

import SwiftUI

struct Home: View {
    @AppStorage("hide") var hide: Bool = false

    @State private var tabSelection = 1
    init() {
        // Customize the appearance of the UITabBar
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(.white)
        appearance.shadowColor = UIColor(.black.opacity(0.3))
        // Change to your desired color
        appearance.backgroundEffect = UIBlurEffect(style: .prominent)
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    var body: some View {
            TabView(selection: $tabSelection){
                FeedView()
                    .tag(1)
                CommunityView()
                    .tag(2)
                
                ClassifiedView()
                    .tag(3)
                
                CarrPoolView()
                    .tag(4)
                
                ProfileView()
                    .tag(5)
                
            }
            .overlay(alignment:.bottom){
                CustomTabView(tabSelection: $tabSelection)
            }
        
       
    }
}
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
