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
    @Binding var Toggle : Bool
    var Livloc: () async -> Void

    var body: some View {
    
            ZStack{
                
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
                    
                    .background(.ultraThinMaterial.opacity(0.9))
                    
                    Text(currentIndex == arrayRoute.count-1 ? "" : arrayRoute[currentIndex + 1])
                        .font(.callout)
                        .opacity(0.2)

                    
                }
                .frame(height: 200)
                .offset(y:-100)
                HStack{
                    Button{
                        withAnimation{
                            currentIndex = (currentIndex + arrayRoute.count - 1) % arrayRoute.count
                            Task{
                                await Livloc()

                            }
                            
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
                    .opacity(!Toggle ? 0.9 : 0.2)
                    .disabled(Toggle)
                    ZStack{
                        
                        
                        Text(arrayRoute.count == currentIndex+1 ? "":String(currentIndex+1))
                            .font(.system(size: 40))
                            .fontWeight(.light)
                            .foregroundColor(.accentColor)
                            .offset(x:-40)
                        Text(arrayRoute.count == currentIndex+1 ? "" : String( arrayRoute.count -  (currentIndex+1) ) )
                            .offset(x:-20)
                            .offset(y:8)
                            .foregroundColor(.white)
                            .opacity(0.8)
                            .font(.caption)
                        Text(arrayRoute.count == currentIndex+1 ? " ":"Cities away")
                            .lineLimit(1)
                            .foregroundColor(.white)
                            .opacity(0.8)
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
                            Task{
                                await Livloc()

                            }

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
                    }.opacity(!Toggle ? 0.9 : 0.2)
                     .disabled(Toggle)
                        
                }
            }

    
        

   
    }
}

struct RouteArray_Previews: PreviewProvider {
    @State static var arrayRoute: [String] = ["A few steps right, you will be in Zurich", "A few steps right, you will be in Zurich", "A few steps right, you will be in Zurich"]
    @State static var currentIndex: Int = 0
    @State static var Toggle: Bool = false

    static var previews: some View {
        RouteArray(arrayRoute: $arrayRoute, currentIndex: $currentIndex, Toggle: $Toggle, Livloc: {})
    }
}
