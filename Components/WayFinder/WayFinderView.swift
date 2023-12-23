//
//  WayFinderView.swift
//  CommunityCloud
//
//  Created by GGS-BKS on 27/09/23.
//

import SwiftUI
import CoreMotion

struct WayFinderView: View {
    
    @AppStorage("hide") var hide: Bool = false

    let cityList: DoublyLinkedList
    
    let pedometer = CMPedometer()
    @State private var stepCount: Int = 0
    
    @State var Toggle = false
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
        cityList.append(city: "Telegram", leftDirection: "And turn right. Take a couple steps left to see you in Instagram", rightDirection: "Take a couple steps right to Budapest")
        cityList.append(city: "Budapest", leftDirection: "Take a couple steps ahead to Telegram", rightDirection: "A few steps right, you will be in Zurich")
        cityList.append(city: "Zurich", leftDirection: "Take a few steps to see you in Budapest", rightDirection: "Walking ahead, you will see Warsaw next to Zurich")
        cityList.append(city: "Warsaw", leftDirection: "Left of Warsaw, you will find Zurich", rightDirection: "Take a walk to the right of Warsaw and turn left to see London")
        cityList.append(city: "London", leftDirection: "Take few Steps and turn right and you'll see Warsaw next to HUBROOM", rightDirection: nil)
    }
    
    var body: some View {
        ZStack{
            CameraView()
//            Color(.black)
            HStack{
                Spacer()
                GifImage("arrow")
                    .rotationEffect(.degrees(hints[currentIndex].contains("turn right") ? 180 : hints[currentIndex].contains("turn left") ? 0 :90))
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                Spacer()
                Spacer()
            }
            VStack{
                SliderButton(Toggle: $Toggle)
                    .offset(y:15)
                    .padding(.top,30)
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
                                }.task{
                                     WayFinder()
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
                                Image(systemName: hints[currentIndex].contains("turn right") ? "arrow.turn.up.right" : hints[currentIndex].contains("turn left") ? "arrow.turn.up.left":"arrow.up")
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

                    
                }
                .padding(.horizontal)
                
                Spacer()
                RouteArray(arrayRoute:$hints, currentIndex: $currentIndex, Toggle: $Toggle, Livloc: LiveLoc)
                    .padding(.bottom)
                
            }
        }
        .overlay{
            
            RoundedButtons()
                
            RouteMap(Current: Current, Destination: Destination)
            
        }
        .onAppear{
            if Toggle{
                startUpdatingSteps()

            }
            withAnimation(.easeInOut(duration: 1)){
                hide = true
            }
            
        }
        .onChange(of: Toggle) { newToggleValue in
                    if newToggleValue {
                        startUpdatingSteps()
                    }
                }
        .onDisappear{
            withAnimation(.easeInOut(duration: 1)){
                hide = false
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .ignoresSafeArea()
    }
    
    func WayFinder()   {
         if let currentCityNode = cityList.findCity(cityName: Current),
            let destinationCityNode = cityList.findCity(cityName: Destination) {

             if currentCityNode === destinationCityNode {
                 print("Already at the destination.")
             } else {
                 // Assume printDirectionsFromCurrentToDestination is an async function
                hints =  cityList.printDirectionsFromCurrentToDestination(currentCity: Current, destinationCity: Destination)

//                 do {
//                     hints = try await cityList.printDirectionsFromCurrentToDestination(currentCity: Current, destinationCity: Destination)
//                 } catch {
//                     // Handle the error here
//                     print("Error: \(error)")
//                 }

             }
         } else {
             print("Current or destination city not found in the list.")
         }
     }
    
    func LiveLoc() {
        //var foundNode = cityList.findNodeWithPointer(pointer: hints[currentIndex])
        if currentIndex == hints.count{
            currentIndex = 0
        }
        if let foundNode = cityList.findNodeWithPointer(pointer: hints[currentIndex]){
            
         
                Current = foundNode.city
                print(Current)
           
        }
        else{
            print("End")
        }
    
    }
    
    func startUpdatingSteps() {
        if CMPedometer.isStepCountingAvailable() {
            pedometer.startUpdates(from: Date()) { pedometerData, error in
                if let data = pedometerData {
                    DispatchQueue.main.async {
                        self.stepCount = data.numberOfSteps.intValue
                        if stepCount > 4{
                            print("next")
                           
                            currentIndex = currentIndex + 1

                            stepCount =  0
                        }
                    }
                    if currentIndex == hints.count - 1{
                        currentIndex = 0
                    }
                    LiveLoc()

                }
            }
        } else {
            // Step counting is not available on this device
            // Handle the error accordingly
            print("Step counting not available on this device.")
        }
    }
   
   



    
    
}
struct WayFinderView_Previews: PreviewProvider {
    static var previews: some View {
        WayFinderView(Current: "Warsaw",Destination: "Telegram")
    }
}


