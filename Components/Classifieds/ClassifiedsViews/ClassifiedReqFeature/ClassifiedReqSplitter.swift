//
//  ClassifiedReqSplitter.swift
//  CommunityCloud
//
//  Created by ARAVIND RM on 15/01/24.
//

import SwiftUI

struct ClassifiedReqSplitter: View {
    var classified : Classified
    
    var onUpdate: (Classified) -> ()
    var onDelete: () -> ()
    
    @State var User_Name : String = ""
    @State private var isLoading = false
    
    var body: some View {
        VStack{
            ForEach(classified.Negotiation,id: \.self){ req in
                // let userReq = pool.Waiting[index]
                ClassifiedReqCardUI(classified: classified, basedonUId: false, userReq:req , onUpdate:onUpdate, onDelete: onDelete)
                
                
            }
        }
    }
}
//#Preview {
//    ClassifiedReqSplitter()
//}
