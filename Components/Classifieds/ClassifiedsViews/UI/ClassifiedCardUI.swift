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

struct ClassifiedCardUI: View {
   
    var classified : Classified
    var basedonUId : Bool
    var onUpdate:(Classified)->()
    var onDelete: () -> ()
    
    @AppStorage("user_UID") var userUID: String = ""
    @State private var docListner: ListenerRegistration?
    
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
                                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                
                            
                        }
                        .frame(width: 150, height:150)
                Spacer()
                VStack(alignment: .leading,spacing: 10) {
                    HStack{
                        Spacer()
                        Menu{
                            if(classified.userUID == userUID){
                                Button("Delete",role:.destructive,action: {deleteClassified()})
                            }
                        }label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal)
                        .padding(.top)
                    }
                    Text(classified.Title)
                              .font(.system(size: 13))
                               .bold()
                                .foregroundColor(.black)
                                .padding(.horizontal)
                                //.offset(y:-20)
                    
                    
                    HStack(spacing:1){
                        Image(systemName: "mappin")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                        Text(classified.Location)
                            .font(.caption)
                            .fontWeight(.light)
                            .foregroundColor(.black)
                            .padding(.trailing)
                        
                    }.offset(x:10)
                  
                    Text("₹ " + String(classified.Price))
                                .font(.system(size: 15))
                                .fontDesign(.rounded)
                                .fontWeight(.semibold)
                                .foregroundColor(.accentColor)
                                .padding(6)

                            .background(
                                RoundedRectangle(cornerRadius: 10).foregroundColor(.gray.opacity(0.4)))
                        .padding(.horizontal)
                        
                        
                        
                    
                   
                    HStack {
                        Spacer()
                        Button{}label:{
                            Image(systemName: "tag")
                                .fontWeight(.light)
                                .rotationEffect(Angle(degrees: -45))
                                .padding(.horizontal)
                        }
                        
                        
                    }
                    Spacer()
                   
                }
                .frame(maxWidth: .infinity,maxHeight: 150)
                  
                    
                    
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
                if docListner == nil{
                    guard let ClassifiedID = classified.id else{return}
                    docListner = Firestore.firestore().collection("Classified").document(ClassifiedID).addSnapshotListener({snapshot,error in
                        if let snapshot{
                            if snapshot.exists{
                                if let updatedClassified = try? snapshot.data(as:Classified.self){
                                    onUpdate(updatedClassified)
                                }
                            }else{
                                onDelete()
                            }
                        }
                    })
                }
        }
        
        
    }
    
    
    func deleteClassified(){
        Task{
            do{
                if classified.imageRefernceID != "" {
                    try await Storage.storage().reference().child("Classified_Images").child(classified.imageRefernceID).delete()
                }
                guard let classifiedID = classified.id else{return}
                try await Firestore.firestore().collection("Classified").document(classifiedID).delete()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    
    
   
    

    
    
    
    
}
var eg = Classified(Title: "book", Price: 2000, Location: "itpl", Description: "buy it bro", imageURl: URL(string:"https://m.media-amazon.com/images/I/81XaiO5ZNuL._SY522_.jpg"), Negotiation: [[:]], userName: "", userUID: "")
#Preview {
    ClassifiedCardUI(classified: eg, basedonUId : false,onUpdate: {_ in }, onDelete: {})
}
