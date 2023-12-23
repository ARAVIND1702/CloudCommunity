//
//  RouteArray.swift
//  CommunityCloud
//
//  Created by GGS-BKS on 28/09/23.
//

import SwiftUI

struct RouteArray: View {
   // @State var arrayRoute : [String] = ["A few steps right, ypu will be in zuriuch", "A few steps right, ypu will be in zuriuch", "A few steps right, ypu will be in zuriuch", "A few steps right, ypu will be in zuriuch"]

    @Binding  var arrayRoute: [String]
    @State private var rotation: Double = -25
    @State private var set: CGFloat = 0
    @Binding  var currentIndex : Int
    var Livloc: () -> Void

    var body: some View {
    
            VStack{
                VStack{
                    
                    Text(currentIndex == 0 ? "" : arrayRoute[currentIndex - 1])
                        .font(.callout)
                        .opacity(0.2)

                    HStack{
                        Spacer()
                        Image(systemName: "location.north.fill")
                            .rotationEffect(.degrees(rotation))
                            .onAppear {
                                withAnimation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                                    rotation = 25
                                    
                                }
                            }
                        Text(arrayRoute[currentIndex])
                            .foregroundColor(.accentColor)
                            .font(.headline)
                            .padding()
                        Spacer()
                    }
                    
                    .background(.gray.opacity(0.2))
                    
                    Text(currentIndex == arrayRoute.count-1 ? "" : arrayRoute[currentIndex + 1])
                        .font(.callout)
                        .opacity(0.2)

                    
                }
                .frame(height: 200)
                
//                HStack {
//                             Button(action: {
//                                 withAnimation {
//                                     currentIndex = (currentIndex + arrayRoute.count - 1) % arrayRoute.count
//                                 }
//                             }) {
//                                 Text("Previous Route")
//                                     .foregroundColor(.white)
//                                     .padding()
//                                     .background(Color.blue)
//                                     .cornerRadius(10)
//                             }
//
//                             Button(action: {
//                                 withAnimation {
//                                     currentIndex = (currentIndex + 1) % arrayRoute.count
//                                 }
//                             }) {
//                                 Text("Next Route")
//                                     .foregroundColor(.white)
//                                     .padding()
//                                     .background(Color.blue)
//                                     .cornerRadius(10)
//                             }
//                         }
                HStack{
                    Button{
                        withAnimation{
                            currentIndex = (currentIndex + arrayRoute.count - 1) % arrayRoute.count
                            Livloc()
                            
                        }
                    }label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.thinMaterial)
                                .frame(width: 150,height: 150)
                                .shadow(color: .black.opacity(0.2), radius: 8)
                                .rotationEffect(.degrees(45))
                                .offset(x:-90)
                            Image(systemName: "chevron.backward")
                                .foregroundColor(.accentColor)
                                .offset(x:-40)

                        }
                    }
                    ZStack{
                        
                        
                        Text(arrayRoute.count == currentIndex+1 ? "":String(currentIndex+1))
                            .font(.system(size: 40))
                            .fontWeight(.light)
                            .foregroundColor(.accentColor)
                            .offset(x:-40)
                        Text(arrayRoute.count == currentIndex+1 ? "" : String( arrayRoute.count -  (currentIndex+1) ) )
                            .offset(x:-20)
                            .offset(y:8)
                            .opacity(0.4)
                            .font(.caption)
                        Text(arrayRoute.count == currentIndex+1 ? " ":"Cities away")
                            .lineLimit(1)
                            .opacity(0.4)
                            .font(.caption)
                            .frame(width:67)
                            .offset(x:20)
                            .offset(y:8)
                        Image(systemName: arrayRoute.count == currentIndex+1 ? "mappin" : "")
                            .offset(x: set)
                            .onAppear {
                                withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                                    set = 5
                                }
                            }
                    }
                   
                    Spacer()
                    Button{
                        withAnimation {
                            currentIndex = (currentIndex + 1) % arrayRoute.count
                            Livloc()

                        }
                        
                    }label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.thinMaterial)
                                .frame(width: 150,height: 150)
                                .shadow(color: .black.opacity(0.2), radius: 8)
                                .rotationEffect(.degrees(45))
                                .offset(x:90)
                            Image(systemName: "chevron.forward")
                                .foregroundColor(.accentColor)
                                .offset(x:40)

                        }
                    }
                        
                }
            }

    
        

   
    }
}

//struct RouteArray_Previews: PreviewProvider {
//    static var previews: some View {
//        RouteArray()
//    }
//}
