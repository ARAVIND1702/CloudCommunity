//
//  BotResponse.swift
//  CommunityCloud
//
//  Created by GGS-BKS on 15/09/23.
//

import Foundation

func getBotResponse(message:String) -> String{
    let tempMessage = message.lowercased()
    
    if tempMessage.contains("hello"){
        return "Hey there! How can i help you"
    } else if tempMessage.contains("goodbye"){
        return "Talk you later!"
    } else if tempMessage.contains("upcoming holiday"){
        return "Its is on 15 Jan 2024 for Pongal"
    }
    else if tempMessage.contains("how to download my pay slip"){
        return """
        HGS Payslip on HGS ESS App
        
        1. Download HGS ESS app from Google Play store and then open the app.
        2. Enter Company Code.
        3. You have to enter your User ID and then portal password,
        4. Click on continue to login.
        5. Enter your portal password again.
        6. Enter a 4 digit pin and confirm pin.
        7. Click on Create Pin button.
"""
  
    }
    else if tempMessage.contains("how are you"){
        return "Im'fine, how about you?"
    }
    else if tempMessage.contains("how are you"){
        return "Im'fine, how about you?"
    }
    else if tempMessage.contains("how are you"){
        return "Im'fine, how about you?"
    }
    else if tempMessage.contains("how are you"){
        return "Im'fine, how about you?"
    } else {
        return "Sorry Im'not trained for that"
    }
}
