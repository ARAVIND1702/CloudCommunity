//
//  ClassifiedView.swift
//  CommunityCloud
//
//  Created by ARAVIND RM on 10/01/24.
//

import SwiftUI

struct ClassifiedView: View {
    var body: some View {
        
            //ScrollView {
//                LazyVStack{
//                ForEach(0..<10) { index in
//                    // Each iteration of the loop creates a new view
//                    ClassifiedCardUI(onUpdate: {_ in }, onDelete: {})
//                }
//            }
      //  }
        ZStack{
            Color(red: 0.973, green: 0.972, blue: 0.981)
                .ignoresSafeArea()
            
            ClassifiedLandingUI()
        }
    }
}
struct ClassifiedView_Previews: PreviewProvider {
    static var previews: some View {
        ClassifiedView()
    }
}
