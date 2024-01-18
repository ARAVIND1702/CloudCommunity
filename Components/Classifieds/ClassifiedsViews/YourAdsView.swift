//
//  AdsView.swift
//  CommunityCloud
//
//  Created by ARAVIND RM on 11/01/24.
//

import SwiftUI
import Firebase

struct YourAdsView: View {
    var basedonUId : Bool = true
    
    @State var Show : Bool =  false
    @State var classifieds: [Classified] = []
    
    @AppStorage("user_UID") var userUID: String = ""

    
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
        ForEach(classifieds) { classified in
          
                ClassifiedCardUI(classified: classified, basedonUId: basedonUId) { updatedClassified in
                    withAnimation(.easeInOut(duration: 0.25)) {
                        if let index = classifieds.firstIndex(where: { $0.id == updatedClassified.id }) {
                            classifieds[index].Request = updatedClassified.Request
                            classifieds[index].Negotiation = updatedClassified.Negotiation
                            classifieds[index].Buyer = updatedClassified.Buyer
                        }
                    }
                } onDelete: {
                    withAnimation(.easeInOut(duration: 0.35)) {
                        classifieds.removeAll { $0.id == classified.id }
                    }
                }
            }
            
        }
    

    
    func fetchPosts() async {
        do {
            var query: Query!
            query = Firestore.firestore().collection("Classified")
            
            if basedonUId {
                // Add the "Joined" constraint using "arrayContains"
                query = query.whereField("userUID", isEqualTo: userUID)

                
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
    YourAdsView()
}
