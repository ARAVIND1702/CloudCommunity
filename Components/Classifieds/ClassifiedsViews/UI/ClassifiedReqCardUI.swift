//
//  ClassifiedCardUI.swift
//  CommunityCloud
//
//  Created by ARAVIND RM on 09/01/24.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
import FirebaseStorage

struct ClassifiedReqCardUI: View {
   
    var classified : Classified
    var basedonUId : Bool
    var userReq : [String:Int]
    var onUpdate:(Classified)->()
    var onDelete: () -> ()
    
    @AppStorage("user_UID") var userUID: String = ""
    @State private var docListner: ListenerRegistration?
    @State var User_uid = ""
    @State var User_Name = ""
    @State var Price = 0
    @State var profileURL : URL? = URL(string: "")
    let dateFormatter: DateFormatter = {
          let formatter = DateFormatter()
          formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
          return formatter
      }()
    
    var body: some View {
        
        
            HStack{
            HStack(){
                        GeometryReader{
                            let size = $0.size
                            WebImage(url:classified.imageURl)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width,height:size.height)
                                .clipShape(RoundedRectangle(cornerRadius: 15,style: .continuous))
                                //.shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                
                            
                        }
                        .padding(.leading,15)
                        .frame(width: 120, height:120)
                Spacer()
                VStack(alignment: .leading,spacing: 10) {
                    HStack{
                        Spacer()
                        Menu{
                            if("1" == "1"){
                                Button("Report",role:.destructive,action: {})
                            }
                        }label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.gray)
                        }
                        .offset(y:14)
                        .padding(.horizontal)
                    }
                    Text(classified.Title)
                              .font(.subheadline)
                              .fontWeight(.medium)
                              .foregroundColor(.black)
                               .padding(.horizontal)
                    
                    HStack{
                        WebImage(url:profileURL).placeholder{
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .foregroundColor(Color(red: 0.339, green: 0.396, blue: 0.95))
                        }
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50,height: 50)
                        .clipShape(Circle())
                        VStack(alignment:.leading,spacing:8){
                            Text(User_Name)
                                .font(.subheadline)
                                .fontWeight(.medium)

                            Divider()
                            Text("Coated Price")
                                .font(.caption)
                                .foregroundStyle(.gray)
                                .fontWeight(.medium)
                            Text("₹ " + String(Price))
                                        .font(.system(size: 12))
                                        .fontDesign(.rounded)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.accentColor)
                                        .padding(6)
                                        
                                    .background(
                                    RoundedRectangle(cornerRadius: 8).foregroundColor(.gray.opacity(0.4)))
                           
                        }
                        Spacer()
                    }.padding(.horizontal)
                  
                   
                        
                    
                   
                    HStack(spacing:10){
                        Spacer().frame(width:4)
                        Button(action:{Ignore()}){
                            Text("Ignore")
                                .font(.system(size: 12))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical,9)
                                .padding(.horizontal,15)
                            
                                .background(
                                    RoundedRectangle(cornerRadius: 8.0)
                                        .fill(Color.red.opacity(0.8))
                                        .shadow(color:.black.opacity(0.1) ,radius: 1 ,y:2)

                                    // You can specify a fill color if desired
                                    
                                    
                                    
                                )
                           
                        }
                        Button(action:{Deal()}){
                            Text("Deal")
                                .font(.system(size: 12))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical,9)
                                .padding(.horizontal,18)
                            
                                .background(
                                    RoundedRectangle(cornerRadius: 8.0)
                                        .fill(Color.green.opacity(0.8))
                                        .shadow(color:.black.opacity(0.1) ,radius: 1 ,y:2)

                                    // You can specify a fill color if desired
                                    
                                    
                                    
                                )
                           
                        }
                        
                        
                    }
                    Spacer()
                   
                }
                .frame(maxWidth: .infinity,maxHeight: 190)
                  
                    
                    
                }
                    
                
                  
                
                    
            }
            .frame(maxWidth: .infinity,minHeight: 100)
            .background(
                RoundedRectangle(cornerRadius: 15.0).fill(.white)
                    
            )
            .overlay(
                RoundedRectangle(cornerRadius: 15.0)
                    .stroke(Color.gray, lineWidth: 0.1)
            )
            //.shadow(color:.gray.opacity(0.3), radius: 4)
            .padding(.horizontal)
            .onAppear(){
                if let (key, value) = userReq.first {
                    User_uid = key
                    Price = value
                } else {
                    print("Dictionary is empty.")
                }
                Task{
                    do {
                        let user = try await Firestore.firestore().collection("Users").document(User_uid).getDocument(as: User.self)

                        await MainActor.run {
                            // Update your properties using data from the user document

                            User_Name = user.username
                            profileURL = user.userProfileURL!
                            
                        }
                    } catch {
                        print(error)
                    }
                    if docListner == nil{
                        docListner = Firestore.firestore().collection("Classified").document(classified.id ?? "").addSnapshotListener({snapshot,error in
                            if let snapshot{
                                if snapshot.exists{
                                    if let updatedPost = try? snapshot.data(as:Classified.self){
                                        onUpdate(updatedPost)
                                    }
                                }else{
                                    onDelete()
                                   
                                }
                            }
                        })
                    }
                }
        }
        
        
    }
    
    func Deal(){
        Task{
           // guard let carpoolID = carpool.id else {return}
        
            Firestore.firestore().collection("Classified").document(classified.id!).updateData([
                    "Buyer": FieldValue.arrayUnion([User_uid])
                ])
                 Firestore.firestore().collection("Classified").document(classified.id!).updateData([
                    "Negotiation": FieldValue.arrayRemove([userReq]),
                    "Request" : FieldValue.arrayRemove([User_uid])
                ])
                
        }
    }
    
    func Ignore(){
        Task{
           // guard let carpoolID = carpool.id else {return}
                 Firestore.firestore().collection("Classified").document(classified.id!).updateData([
                    "Negotiation": FieldValue.arrayRemove([userReq]),
                    "Request" : FieldValue.arrayRemove([User_uid])
                ])
                
        }
    }
    
    
    
    
   
    

    
    
    
    var eg = Classified(Title: "Book", Price: 2000, Location: "itpl", Description: "buy it bro", Negotiation: [], userName: "", userUID: "")
}

//#Preview {
//    ClassifiedReqCardUI(classified: eg, basedonUId : false, userReq: ["String" : 100],onUpdate: {_ in }, onDelete: {})
//}
