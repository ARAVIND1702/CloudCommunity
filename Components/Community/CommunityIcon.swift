//
//  CommunityIcon.swift
//  CommunityCloud
//
//  Created by ARAVIND RM on 08/01/24.
//

import SwiftUI

struct CommunityIcon: View {
    
    @State var Community: String
    @State var Icon: String = ""
    
    
    
    
    var body: some View {
        Image(systemName: Icon)
            .padding(12)
            .frame(width: 50,height: 50)
            .foregroundColor(.white)
            .font(.callout)
            .background(Circle().fill(Color.accentColor))
            .clipShape(Circle())
            .shadow(color: .black.opacity(0.1), radius: 7)
            .onAppear(perform: setIcon)
    }
    
    func setIcon() {
        switch Community {
        case "Open_Source":
            Icon = "apple.terminal"
        case "Podcasts":
            Icon = "message.and.waveform.fill"
        case "Riders_Club":
            Icon = "road.lanes"
        case "Cinephile":
            Icon = "popcorn.fill"
        case "Audiophile":
            Icon = "beats.headphones"
        case "Sports_Club":
            Icon = "figure.table.tennis"
        default:
            Icon = "default.icon" // Set a default icon or handle the case accordingly
        }
    }
}
#Preview {
    CommunityIcon(Community: "OpenSource")
}
