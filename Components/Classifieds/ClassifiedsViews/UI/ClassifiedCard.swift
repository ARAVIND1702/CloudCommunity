//
//  ClassifiedCard.swift
//  CommunityCloud
//
//  Created by ARAVIND RM on 17/01/24.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
import FirebaseStorage

struct ClassifiedCard: View {
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
        VStack(alignment: .leading,spacing: 0){
            
            GeometryReader{
                let size = $0.size
                WebImage(url:classified.imageURl)
                    .resizable()
                    .scaledToFill()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width,height:size.height)
                    .clipped()
                // .clipShape(RoundedRectangle(cornerRadius: 15,style: .continuous))
                    //.shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    
                
            }
            .overlay {
                Text("Book")
                    .font(Font.system(size: 16))
                    .foregroundStyle(.white)
                    .fontWeight(Font.Weight.medium)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color.accentColor.opacity(0.8))
                    )
                    .offset(x: -145, y:-175)
            }
            .frame(maxWidth:UIScreen.main.bounds.width,maxHeight: 400)
            VStack(alignment: .leading,spacing: 6){
                Text(classified.Title)
                    .fontWeight(Font.Weight.heavy)
                Text(classified.Location)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.gray)
            }.padding()
            HStack(alignment: .center,spacing: 6){
                Text("Price :")
                    .font(Font.system(size: 13))
                    .fontWeight(Font.Weight.heavy)
                HStack{
                    Text("₹" + String(classified.Price))
                        .font(.title3)
                        .padding(.horizontal,10)
                        .padding(.vertical,5)
                        .foregroundColor(Color.white)
                }
                .background(Color.accentColor.opacity(0.8))
                .cornerRadius(7)
                Spacer()
                Text("BUY NOW")
                    .fontWeight(Font.Weight.heavy)
                    .foregroundColor(Color.accentColor)
                    

            }
            .padding(.horizontal)
            .padding(.bottom)
                 
            
        }
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color:Color.black.opacity(0.2),radius: 8,x: 0,y:2)
        .padding()
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
    
    var eg = Classified(Title: "book", Price: 2000, Location: "itpl", Description: "buy it bro", imageURl: URL(string:"https://m.media-amazon.com/images/I/81XaiO5ZNuL._SY522_.jpg"), Negotiation: [[:]], userName: "", userUID: "")
}


#Preview {
    ClassifiedCard(classified: eg, basedonUId: false, onUpdate: {_ in }, onDelete: {})
}
