//
//  RouteMap.swift
//  CommunityCloud
//
//  Created by GGS-BKS on 05/10/23.
//

import SwiftUI

struct RouteMap: View {
    @State var Current :String
    @State var Destination :String
    @State private var isExpanded = false

    var body: some View {
        
        VStack{
            Spacer()
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
                            Image(systemName: "mappin.circle.fill")
                            //                                .offset(y:isExpanded ? 0 : -48)
                            
                            //
                            //
                            //                                Text("Auto mode detects the motions and steps to navigate automatically")
                            //                                    .foregroundColor(.black)
                            //                                    .opacity(isExpanded ? 0 : 1)
                            //                                    .padding()
                        }
                }
            }.padding()
        
            Spacer()
            VStack{
                Text("Live Marker")
                    .padding(.top)
                   .multilineTextAlignment(.center)
                      .foregroundColor(.black)
                ZStack{
                    Image("Map")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        .shadow(radius: 4)
                    ZStack{
                     
                        Circle().foregroundColor(.white).frame(width: 9)
                        
                        Circle()
                            .foregroundColor(.accentColor).opacity(0.0)
                            .frame(width: 14)
                            .overlay(
                                Circle()
                                    .stroke(Color.accentColor, lineWidth: 0.8) // You can adjust the stroke color and width as desired
                            )
                    }.offset(x: {
                        if Current == "Instagram" {
                            return -155
                        }else if Current == "Telegram" {
                            return -155
                        }else if Current == "Budapest" {
                            return -70
                        }else if Current == "Zurich" {
                            return -15
                        }else if Current == "Warsaw" {
                            return 35
                        }else if Current == "London" {
                            return 125
                        } else {
                            return -155
                        }
                    }(),y: {
                        if Current == "Instagram" {
                            return 0.0
                        } else if Current == "Telegram" {
                            return 55
                        }else if Current == "Budapest" {
                            return 90
                        }else if Current == "Zurich" {
                            return 90
                        }else if Current == "Warsaw" {
                            return 90
                        }else if Current == "London" {
                            return 90
                        }
                        else{
                            return 0
                        }
                    }())

                    Image(systemName: "mappin.and.ellipse")
                        .font(.callout)
                        .foregroundColor(.white)
                        .offset(x: {
                            if Destination == "Instagram" {
                                return -155
                            }else if Destination == "Telegram" {
                                return -155
                            }else if Destination == "Budapest" {
                                return -70
                            }else if Destination == "Zurich" {
                                return -15
                            }else if Destination == "Warsaw" {
                                return 35
                            }else if Destination == "London" {
                                return 125
                            } else {
                                return -155
                            }
                        }(),y: {
                            if Destination == "Instagram" {
                                return 0.0
                            } else if Destination == "Telegram" {
                                return 55
                            }else if Destination == "Budapest" {
                                return 90
                            }else if Destination == "Zurich" {
                                return 90
                            }else if Destination == "Warsaw" {
                                return 90
                            }else if Destination == "London" {
                                return 90
                            }
                            else{
                                return 0
                            }
                        }())
//                    DottedLine()
//                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
//                                .frame(width: 200, height: 2) // Adjust the width and height of the line
                }
                
            }.background(RoundedRectangle(cornerRadius: 12).fill(Color(red: 0.973, green: 0.972, blue: 0.981)))
                .offset(y: isExpanded ? -280 : 290)
                .padding()
            
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

struct RouteMap_Previews: PreviewProvider {
    static var previews: some View {
        RouteMap(Current: "Warsaw", Destination: "London")
    }
}


/// instagram x:-170

struct DottedLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}
