//
//  RoomCards.swift
//  CommunityCloud
//
//  Created by GGS-BKS on 22/09/23.
//

import SwiftUI

struct RoomCards:View,Identifiable  {
    var id = UUID()
    @State var islarge = true
    @State var RoomName : String = ""
    @State var ImageName : String = ""
    var body: some View {
        if(islarge){
            ZStack(alignment:.center){
                       Image(ImageName) // Replace "Munich" with the name of your image asset
                           .resizable()
                           .aspectRatio(contentMode: .fill)
                           .frame(width: 182, height: 300) // Adjust the size as needed
                           .clipShape(RoundedRectangle(cornerRadius: 25))
                       
                ZStack {
                    VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
                        .modifier(TopCornersModifier(radius: 25))
                        .frame(width: 182, height: 90)
                   
                    HStack{
                        VStack(alignment: .leading,spacing: 10){
                            Text(RoomName)
                                .font(.body)
                                .fontWeight(.medium)
                            HStack{
                                Text("4 pax")
                                    .font(.footnote)
                                    
                                Image(systemName: "tv").font(.body)
                                Image(systemName: "video").font(.body)
                            }
                        }
                        Spacer()
                        Image(systemName: "heart")
                            .font(.body)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 180)
                }
                .offset(y:-105)
                    
                
                   }

        }else{
            ZStack(alignment:.center){
                       Image(ImageName) // Replace "Munich" with the name of your image asset
                           .resizable()
                           .aspectRatio(contentMode: .fill)
                           .frame(width: 180, height: 190) // Adjust the size as needed
                           .clipShape(RoundedRectangle(cornerRadius: 25))
                       
                ZStack {
                    VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
                        .modifier(TopCornersModifier(radius: 25))
                        .frame(width: 180, height: 80)
                   
                    HStack{
                        VStack(alignment: .leading,spacing: 10){
                            Text(RoomName)
                                .font(.body)
                                .fontWeight(.medium)
                            HStack{
                                Text("4 pax")
                                    .font(.footnote)
                                    
                                //Image(systemName: "tv").font(.body)
                                //Image(systemName: "video").font(.body)
                            }
                        }
                        Spacer()
                        Image(systemName: "heart")
                            .font(.body)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 180)
                }
                .offset(y:-55)
                    
                
                   }
        }
      
        
    }
}

struct RoomCards_Previews: PreviewProvider {
    static var previews: some View {
        RoomCards()
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}



struct TopCornersModifier: ViewModifier {
    var radius: CGFloat

    func body(content: Content) -> some View {
        content
            .clipShape(TopCornersShape(radius: radius))
    }
}

struct TopCornersShape: Shape {
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let minX = rect.minX
        let maxX = rect.maxX
        let minY = rect.minY
        let maxY = rect.maxY

        path.move(to: CGPoint(x: minX, y: maxY))
        path.addLine(to: CGPoint(x: minX, y: minY + radius))
        path.addArc(center: CGPoint(x: minX + radius, y: minY + radius), radius: radius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        path.addLine(to: CGPoint(x: maxX - radius, y: minY))
        path.addArc(center: CGPoint(x: maxX - radius, y: minY + radius), radius: radius, startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 0), clockwise: false)
        path.addLine(to: CGPoint(x: maxX, y: maxY))

        return path
    }
}
