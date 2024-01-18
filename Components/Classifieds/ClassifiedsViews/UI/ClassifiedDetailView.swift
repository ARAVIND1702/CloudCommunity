//
//  ClassifiedDetailView.swift
//  CommunityCloud
//
//  Created by ARAVIND RM on 14/01/24.
//

import SwiftUI

import SDWebImageSwiftUI
import Firebase
import FirebaseStorage
/// <#Description#>
//@available(iOS 17.0, *)
struct ClassifiedDetailView: View {
   //binding
    @Binding var Show: Bool
    var classified: Classified

    @AppStorage("user_UID") var userUID: String = ""
    @State private var docListner: ListenerRegistration?
    @State private var selectedMoney: Double
    @State private var ReqBtn: String = "Request"
    @State var keypair: [String: Int] = ["hello" : 5]

    init(Show: Binding<Bool>, classified: Classified) {
        self._Show = Show
        self.classified = classified
        _selectedMoney = State(initialValue: Double(classified.Price))
//        _keypair = State(initialValue: ["k":89.0]) // Initialize with an empty dictionary
//       // super.init()
//
//        // Now you can set the initial value for keypair
        keypair = [classified.userUID: Int(selectedMoney)]
    }



    
    var body: some View {
        VStack(){
            HStack {
                Button{
                    Show = false
                }label:{
                    Image(systemName: "chevron.backward")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .font(.headline)
            }
                Spacer()
            }.padding(.bottom)
              .padding(.horizontal,20)
            HStack{
                WebImage(url:classified.userProfileURL).placeholder{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .foregroundColor(Color(red: 0.339, green: 0.396, blue: 0.95))
                }
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50,height: 50)
                .clipShape(Circle())
                VStack(alignment:.leading){
                    Text(classified.userName)
                        .font(.system(size: 13))
                        .bold()
                    Text(classified.publishdedDate.formatted(date: .abbreviated,time: .shortened))
                        .font(.caption2)
                        .foregroundColor(.gray)
                    //                        .foregroundColor(.gray)
                    //                    Text(post.publishdedDate.formatted(date: .abbreviated,time: .shortened))
                    //                        .font(.caption2)
                    //                        .foregroundColor(.gray)
                }
                Spacer()
            }.padding(.horizontal)
            
            VStack{

                ZStack {
                    GeometryReader{
                        let size = $0.size
                        WebImage(url:classified.imageURl)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width,height:size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 10,style: .continuous))
                    }
                    .frame(height:200)
                    .padding()
                    Text("₹ " + String(classified.Price))
                                .font(.system(size: 20))
                                .fontDesign(.rounded)
                                .fontWeight(.semibold)
                                .foregroundColor(.green)
                                .padding(6)
                                .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.ultraThinMaterial.opacity(0.8))
                            )
                                .offset(x:120,y:60)
                }
                VStack(alignment: .leading){
                    HStack{
                        Text(classified.Title)
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        Spacer()
                    }
                    HStack(spacing:1){
                        Image(systemName: "mappin")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                        Text(classified.Location)
                            .font(.caption)
                            .bold()
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                    Divider()
                    Text("Description")
                        .font(.headline)
                    Text(classified.Description)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .padding(5)
                    Divider()
                    Text("Negotiate")
                        .font(.headline)
                    HStack {
                        Spacer()
                        Text("₹ " + String(selectedMoney))
                                    .font(.system(size: 20))
                                    .fontDesign(.rounded)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.accentColor)
                                    .padding(6)
                                    
                                .background(
                                RoundedRectangle(cornerRadius: 8).foregroundColor(.gray.opacity(0.4)))
                        Spacer()
                    }
                    Slider(value: $selectedMoney, in: 0...Double(classified.Price), step: 5)
                                    .padding()
                    
                        
                }.padding(.horizontal)
                
            }
            Button{
                Joined()
                
                }label: {
                    Text(ReqBtn)
                        .lineLimit(1)
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .foregroundColor(ReqBtn == "Request" ? .white : .black)
                        .frame(width: 120)
                        .padding(.vertical, 19)
                        .padding(.horizontal, 100)
                        .background(
                            RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                               // .stroke(Color.accentColor, lineWidth: 1.5)
                                .fill(ReqBtn == "Request" ? Color(red: 0.339, green: 0.396, blue: 0.95) : .white)
                                .shadow(color: .black.opacity(0.1), radius: 1, y: 2)
                        )

                }

            Spacer()
        } .onAppear(){
            
            Task{
//                await timeConverter()
//                guard let carpoolID = carpool.id else {return}
                if classified.Request.contains(userUID){
                    ReqBtn = "Cancel Request"
                }
                else{
                    ReqBtn = "Request"
                    
                }
                
                
            }
        }
    }
    func Joined(){
        keypair = [userUID:Int(selectedMoney)]
        Task{
            guard let classifiedID = classified.id else {return}
            if classified.Request.contains(userUID){
                Firestore.firestore().collection("Classified").document(classifiedID).updateData([
                    "Request": FieldValue.arrayRemove([userUID]),
                   "Negotiation": FieldValue.arrayRemove([keypair])
                ])
                    ReqBtn = "Request"
                
           
            }
            else{
                Firestore.firestore().collection("Classified").document(classifiedID).updateData([
                    "Request": FieldValue.arrayUnion([userUID]),
                    "Negotiation": FieldValue.arrayUnion([keypair])

                ])
            
                    ReqBtn = "Cancel Request"
                

            }
                
                
        }
    }
}
var cl = Classified(Title: "asas", Price: 20, Location: "loca", Description: "description", Negotiation: [[:]], userName: "aravind", userUID: "userUID")
#Preview {
        ClassifiedDetailView(Show: .constant(true), classified: cl)
    
    
    
}
