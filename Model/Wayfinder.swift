import Foundation

class Node {
    let city: String
    var previous: Node?
    var next: Node?
    
    // Directional information
    var leftDirection: String?
    var rightDirection: String?
    
    init(city: String) {
        self.city = city
    }
}

class DoublyLinkedList {
    var head: Node?
    var tail: Node?
    
    func append(city: String, leftDirection: String?, rightDirection: String?) {
        let newNode = Node(city: city)
        
        // Set directional information
        newNode.leftDirection = leftDirection
        newNode.rightDirection = rightDirection
        
        if let tailNode = tail {
            tailNode.next = newNode
            newNode.previous = tailNode
            tail = newNode
        } else {
            head = newNode
            tail = newNode
        }
    }
    
    func printCitiesWithDirections() {
        var current = head
        while let node = current {
            print(node.city, terminator: " <-> ")
            
            if let leftDirection = node.leftDirection {
                print(leftDirection, terminator: " <-> ")
            }
            
            if let rightDirection = node.rightDirection {
                print(rightDirection, terminator: " <-> ")
            }
            
            current = node.next
        }
        print("nil")
    }
    
    func findCity(cityName: String) -> Node? {
        var current = head
        while let node = current {
            if node.city.lowercased() == cityName.lowercased() {
                return node
            }
            current = node.next
        }
        return nil
    }
//
    func printDirectionsFromCurrentToDestination(currentCity: String, destinationCity: String) -> [String] {
        var route : [String] = []
        if let currentNode = findCity(cityName: currentCity),
           let destinationNode = findCity(cityName: destinationCity) {

            var current: Node? = currentNode

            // Determine if the destination node is on the left or right
            var isDestinationOnLeft = false
            while current !== nil {
                if current === destinationNode {
                    isDestinationOnLeft = true
                    break
                }
                current = current?.previous
            }

            current = currentNode
            while current !== nil {
                if let leftDirection = current?.leftDirection, isDestinationOnLeft {
                    //print(leftDirection)
                    route.append(leftDirection)
                }
                if let rightDirection = current?.rightDirection, !isDestinationOnLeft {
                   // print(rightDirection)
                    route.append(rightDirection)

                }

                if current === destinationNode {
                   // print("Reached \(destinationCity)")
                    route.append("Reached \(destinationCity)")

                    break
                }
                current = isDestinationOnLeft ? current?.previous : current?.next
            }
        } else {
            print("Current or destination city not found in the list.")
        }
        return route
    }

    
    
    


    

  
    
    func findNodeWithPointer(pointer: String) -> Node? {
        var current = head
        while let node = current {
            if node.leftDirection == pointer || node.rightDirection == pointer {
                return node
            }
            current = node.next
        }
        return nil
    }

}

// Create a doubly linked list of cities with directions

//    let cityList = DoublyLinkedList()
//    cityList.append(city: "Instagram", leftDirection: "Work in Progress", rightDirection: "Take a couple steps right to see Telegram")
//    cityList.append(city: "Telegram", leftDirection: "And turn slight right. Take a couple steps left to see you in Instagram", rightDirection: "Take a couple steps right to Budapest")
//    cityList.append(city: "Budapest", leftDirection: "Take a couple steps ahead to Telegram", rightDirection: "A few steps right, you will be in Zurich")
//    cityList.append(city: "Zurich", leftDirection: "Take a few steps to see you in Budapest", rightDirection: "Walking ahead, you will see Warsaw next to Zurich")
//    cityList.append(city: "Warsaw", leftDirection: "Left of Warsaw, you will find Zurich", rightDirection: "Take a walk to the right of Warsaw and turn left to see London")
//    cityList.append(city: "London", leftDirection: "Take few Steps and turn Right and you'll see Warsaw next to HUBROOM", rightDirection: nil)
//
//    // Take user input for current and destination cities
//    let currentCity = "Budapest"
//    let destinationCity = "Warsaw"
//
//    if let currentCityNode = cityList.findCity(cityName: currentCity),
//           let destinationCityNode = cityList.findCity(cityName: destinationCity) {
//
//               if currentCityNode === destinationCityNode {
//                   print("Already at the destination.")
//               } else {
//                   cityList.printDirectionsFromCurrentToDestination(currentCity: currentCity, destinationCity: destinationCity)
//               }
//           } else {
//               print("Current or destination city not found in the list.")
//           }
//
//    // Print the list with directions
//    cityList.printCitiesWithDirections()

