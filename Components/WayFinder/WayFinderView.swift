//
//  WayFinderView.swift
//  CommunityCloud
//
//  Created by GGS-BKS on 27/09/23.
//

import SwiftUI

struct WayFinderView: View {
    let cityList: DoublyLinkedList
    @State var Current: String
    @State var Destination: String
    @State var hints : [String] = ["Route 1", "Route 2", "Route 3", "Route 4"]
    @State  var currentIndex = 0
    init(Current : String,Destination : String) {
        self.Current = Current
        self.Destination = Destination

        // Initialize and populate the doubly linked list here
        cityList = DoublyLinkedList()
        cityList.append(city: "Instagram", leftDirection: "Work in Progress", rightDirection: "Take a couple steps right to see Telegram")
        cityList.append(city: "Telegram", leftDirection: "And turn slight right. Take a couple steps left to see you in Instagram", rightDirection: "Take a couple steps right to Budapest")
        cityList.append(city: "Budapest", leftDirection: "Take a couple steps ahead to Telegram", rightDirection: "A few steps right, you will be in Zurich")
        cityList.append(city: "Zurich", leftDirection: "Take a few steps to see you in Budapest", rightDirection: "Walking ahead, you will see Warsaw next to Zurich")
        cityList.append(city: "Warsaw", leftDirection: "Left of Warsaw, you will find Zurich", rightDirection: "Take a walk to the right of Warsaw and turn left to see London")
        cityList.append(city: "London", leftDirection: "Take few Steps and turn Right and you'll see Warsaw next to HUBROOM", rightDirection: nil)
    }
    
    var body: some View {
        VStack{
            Spacer()
            VStack(alignment: .leading,spacing: 14){
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .frame(width: 350, height: 100)
                    .shadow(color:.black.opacity(0.1) ,radius: 2 ,y:2)
                    .overlay{
                        HStack{
                            Image(systemName: "arrow.up")
                                .foregroundColor(.blue)
                                .fontWeight(.bold)
                                .font(.system(size: 40))
                            VStack(alignment: .leading,spacing: 10){
                                Text(Current)
                                    .fontWeight(.heavy)
                                    .font(.system(size: 20))
                                Text("toward \(Destination)")
                                    .fontWeight(.medium)
                                    .font(.system(size: 15))
                            }.onAppear{
                                Wayfiner()
                            }
                            
                            Spacer()
                        }.padding()
                        
                    }
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .frame(width: 130, height: 70)
                    .shadow(color:.black.opacity(0.1) ,radius: 2 ,y:2)
                    .overlay{
                        HStack{
                            Text("Then")
                                .fontWeight(.semibold)
                                .font(.system(size: 20))
                            Image(systemName: "arrow.turn.up.right")
                                .foregroundColor(.blue)
                                .fontWeight(.bold)
                                .font(.system(size: 25))
                            
                            
                        }.padding()
                        
                    }
                
                
//                ForEach(hints, id: \.self) { route in
//
//                        Text(route)
//
//                           }

                
            }.padding()
            Spacer()
            RouteArray(arrayRoute:$hints, currentIndex: $currentIndex, Livloc: LiveLoc)
            Spacer()
            
        }
        .background(Color(red: 0.973, green: 0.972, blue: 0.981))
        .ignoresSafeArea()
    }
    
    func Wayfiner(){
        if let currentCityNode = cityList.findCity(cityName: Current),
           let destinationCityNode = cityList.findCity(cityName: Destination) {
            
            if currentCityNode === destinationCityNode {
                print("Already at the destination.")
            } else {
                hints = cityList.printDirectionsFromCurrentToDestination(currentCity: Current, destinationCity: Destination)
            }
        } else {
            print("Current or destination city not found in the list.")
        }
        
    }
    
    func LiveLoc(){
        //var foundNode = cityList.findNodeWithPointer(pointer: hints[currentIndex])
        if let foundNode = cityList.findNodeWithPointer(pointer: hints[currentIndex]){
            Current = foundNode.city
        }
        else{
            print("End")
        }
    
    }
   
    
    
    
}
struct WayFinderView_Previews: PreviewProvider {
    static var previews: some View {
        WayFinderView(Current: "Warsaw",Destination: "Telegram")
    }
}


