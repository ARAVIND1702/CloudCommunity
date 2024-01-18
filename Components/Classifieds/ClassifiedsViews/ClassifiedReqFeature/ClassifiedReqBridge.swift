//
//  AdsView.swift
//  CommunityCloud
//
//  Created by ARAVIND RM on 11/01/24.
//

import SwiftUI
import Firebase

struct ClassifiedReqBridge: View {
    var basedonUId : Bool = false
    var uid : String = ""
    
    @State var Show : Bool =  false
    @State var classifieds: [Classified] = []
    
    @State var isFetching: Bool = true
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            LazyVStack{
                if isFetching{
                    ProgressView()
                        .padding(.top,30)
                }else{
                    if classifieds.isEmpty{
                        Text("No Classified's Found")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.top,30)
                    }else{
                        ClassifiedListView()
                            .padding(.vertical)
                    }
                }
            }
        }
        .refreshable {
            guard !basedonUId else {return}
            isFetching = true
            classifieds = []
            await fetchPosts()
        }
        .task {
            guard classifieds.isEmpty else{ return }
            await fetchPosts()
            
        }
    }
    
    @ViewBuilder
    func ClassifiedListView() -> some View {
        VStack { // Use a container view, such as VStack
            var hasNonEmptyWaitingList = false
            ForEach(classifieds, id: \.id) { classified in
                if(!classified.Request.isEmpty){
                    ClassifiedReqSplitter(classified:classified){updatedClassified in
                        withAnimation(.easeInOut(duration: 0.25)){
                            if let index = classifieds.firstIndex(where: { classified in
                                classified.id == updatedClassified.id
                                
                            }){
                                classifieds[index].Request = updatedClassified.Request
                                classifieds[index].Negotiation = updatedClassified.Negotiation
                                classifieds[index].Buyer = updatedClassified.Buyer
                                
                            }
                            
                        }
                    }onDelete: {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            classifieds.removeAll { classified.id == $0.id}
                        }
                    }
                }
                else{
                    Text("No Request Found")
                        .font(.callout)
                        .foregroundColor(.gray)
                     }
            }
//            if !hasNonEmptyWaitingList {
//                    Text("No Request Found")
//                        .font(.callout)
//                        .foregroundColor(.gray)
//                }
        }
    }

    
    func fetchPosts() async {
        do {
            var query: Query!
            query = Firestore.firestore().collection("Classified")
            
            if basedonUId {
                // Add the "Joined" constraint using "arrayContains"
                query = query.whereField("Joined", arrayContainsAny:[uid])
                
                
            }
            
            // Add additional "OR" conditions here
            //            let field1Value = "value1" // Replace with your desired field value
            //            let field2Value = "value2" // Replace with your desired field value
            //
            //            // Example "OR" condition 1
            //            query = query.whereField("Joined", isEqualTo: uid)
            
            // Example "OR" condition 2
            
            let docs = try await query.getDocuments()
            let fetchedPosts = docs.documents.compactMap { doc -> Classified? in
                try? doc.data(as: Classified.self)
            }
            
            await MainActor.run {
                classifieds = fetchedPosts
                isFetching = false
            }
        } catch {
            print(error)
            print("hi - error")
        }
    }
}
#Preview {
    ClassifiedReqBridge()
}
