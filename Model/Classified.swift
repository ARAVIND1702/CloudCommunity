//
//  Classified.swift
//  CommunityCloud
//
//  Created by ARAVIND RM on 11/01/24.
//
//
//  EventCard.swift
//  CommunityCloud
//
//  Created by GGS-BKS on 28/08/23.
//


import Foundation
import FirebaseFirestoreSwift
import SwiftUI

struct Classified:Identifiable,Codable,Equatable,Hashable {
    @DocumentID var id: String?
//    var id = UUID() // This should be a unique identifier for each event
    var Title : String
    var Price: Int
    var Location : String 
    var Request: [String] = []
    var Buyer: [String] = []
    var Description : String
    var imageURl:URL?
    var imageRefernceID: String = ""
    var publishdedDate: Date = Date()
    var Negotiation: [[String: Int]] = [] // Change here to an array of dictionaries
    var userProfileURL : URL?// add when you are adding dp pic for every account //by ARAVIND RM
//    var dislikedIDs: [String] = []
    
//Basic info
    var userName :String
    var userUID :String
    
    enum CodingKeys:String, CodingKey {
        case Title
        case id
        case Price
        case Request
        case Buyer
        case Location
        case Description // Typo corrected, should be "publishedDate"
        case imageURl
        case imageRefernceID
        case publishdedDate
        case userUID
        case userName
        case userProfileURL
        case Negotiation
        //URL  add when you are adding dp pic for every account //by ARAVIND RM
    }


    
}

