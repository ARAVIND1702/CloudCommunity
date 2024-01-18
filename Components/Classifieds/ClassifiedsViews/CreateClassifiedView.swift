//
//  CreateClassifiedView.swift
//  CommunityCloud
//
//  Created by ARAVIND RM on 11/01/24.
//

import SwiftUI
import SDWebImageSwiftUI
import PhotosUI
import FirebaseFirestoreSwift
import FirebaseStorage
import Firebase
struct CreateClassifiedView: View {
    
    var onPublish: (Classified)->()
    @Binding var Show: Bool

    
    @State private var title = ""
    @State private var location = ""
    @State private var description = ""
    @State private var price : Int = 0
    @State private var showAlert = false
    @State private var errorMessage = ""
    @State private var isLoading = false
    
    @State var postImageData : Data?

    @Environment(\.dismiss) private var dismiss
    // @State private var isLoading: Bool = false
    // @State private var errorMessage: String = ""

     @State private var showImagePicker: Bool = false
     @State private var photoItem: PhotosPickerItem?
     @FocusState private var showkeyboard: Bool

    ///
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("log_status") var userIsLoggedIn:Bool = false
    @AppStorage("user_name") var usernamestored: String = ""
    @AppStorage("user_UID") var userUID: String = ""

    
    func handle(error: Error?) {
            if let error = error {
                errorMessage = error.localizedDescription
                showAlert = true
            }
        }
    
    var body: some View {
        ScrollView(.vertical){
            ZStack(){
                Color(red: 0.973, green: 0.972, blue: 0.981)
                    .ignoresSafeArea()
                
                VStack(){
                    HStack{
                        Text("Post Ad")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .font(.system(size: 34))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal,24)
                            
                            Spacer()
                    }.padding(.bottom)
                        .padding(.top)
                    HStack{
                        Text("Title")
                            .fontWeight(.semibold)
                            .foregroundStyle(.black.opacity(0.5))
                            .font(.subheadline)
                            .padding(.leading,25)
                        Spacer()
                    }
                    RoundedRectangle(cornerRadius: 15, style: .circular)
                        .stroke(Color.accentColor, lineWidth: 1.5)

                        .foregroundColor(.white) // Set the background color
                        .frame(height: 60) // Adjust the height of the RoundedRectangle
                    
                        .overlay(
                            TextField("Title",text: $title)
                                .foregroundColor(.black)
                                .padding(.horizontal,16)
                        )
                        .padding(.horizontal, 24)
                        .padding(.bottom,14)
                    HStack{
                        Text("Description")
                            .fontWeight(.semibold)
                            .foregroundStyle(.black.opacity(0.5))
                            .font(.subheadline)
                            .padding(.leading,25)
                        Spacer()
                    }
                    RoundedRectangle(cornerRadius: 15, style: .circular)
                        .stroke(Color.accentColor, lineWidth: 1.5)

                        .foregroundColor(.white) // Set the background color
                        .frame(height: 100) // Adjust the height of the RoundedRectangle
                        .overlay(
                            TextField("Description",text: $description , axis: .vertical)
                                .frame(minHeight:100)
                                .foregroundColor(.black)
                                .padding(.horizontal,16)
                        )
                        .padding(.horizontal, 24)
                        .padding(.bottom,14)

                    HStack{
                        Text("Price")
                            .fontWeight(.semibold)
                            .foregroundStyle(.black.opacity(0.5))
                            .font(.subheadline)
                            .padding(.leading,25)
                        Spacer()
                    }
                    RoundedRectangle(cornerRadius: 15, style: .circular)
                        .stroke(Color.accentColor, lineWidth: 1.5)
                        .foregroundColor(.white) // Set the background color
                        .frame(height: 60) // Adjust the height of the RoundedRectangle
                    
                        .overlay(
                            TextField("Price", value: $price, formatter: NumberFormatter())
                                .foregroundColor(.black)
                                .padding(.horizontal,16)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()

                        )
                        .padding(.horizontal, 24)
                        .padding(.bottom,14)
                    HStack{
                        Text("Location")
                            .fontWeight(.semibold)
                            .foregroundStyle(.black.opacity(0.5))
                            .font(.subheadline)
                            .padding(.leading,25)
                        Spacer()
                    }
                    RoundedRectangle(cornerRadius: 15, style: .circular)
                        .stroke(Color.accentColor, lineWidth: 1.5)
                        .foregroundColor(.white) // Set the background color
                        .frame(height: 60) // Adjust the height of the RoundedRectangle
                    
                        .overlay(
                            TextField("Location", text: $location)
                                .foregroundColor(.black)
                                .padding(.horizontal,16)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()

                        )
                        .padding(.horizontal, 24)
                        .padding(.bottom,14)
                    
                  
                    if let postImageData, let image = UIImage(data: postImageData){
                        GeometryReader{
                            let size = $0.size
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width:size.width, height:size.height)
                                .clipShape(RoundedRectangle(cornerRadius: 10.0,style: .continuous))
                                .overlay(alignment: .topTrailing){
                                    Button{
                                        withAnimation(.easeInOut(duration: 0.45)){
                                            self.postImageData = nil
                                        }
                                    }label:{
                                        Image(systemName: "trash")
                                            .fontWeight(.bold)
                                            .tint(.red)
                                            .padding()
                                    }
                                }
                        }.clipped()
                            .frame(height: 220)
                            .padding()

                    }
                    HStack{
                        
                        
                        Button(action:Publish, label: { RoundedRectangle(cornerRadius: 15, style: .circular)
                                .frame(height: 60)
                                .overlay(
                                    Text("Publish")
                                        .fontDesign(.rounded)
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                    
                                )
                                .padding(.leading, 24)
                                .padding(.trailing, postImageData == nil ? 0 : 24)
                            
                        }
                        )
                        if(postImageData == nil){
                            Button(action:{ showImagePicker = !showImagePicker}, label: { RoundedRectangle(cornerRadius: 15, style: .circular)
                                    .frame(width:60, height: 60)
                                    .overlay(
                                        Image(systemName: "photo.fill.on.rectangle.fill")
                                            .foregroundColor(.white)
                                            .fontWeight(.bold)
                                    )
                                
                            }).padding(.trailing,24)
                            
                        }}
    //                Image("logo")
    //                    .resizable()
    //                    .aspectRatio(contentMode: .fit)
    //                    .frame(width: 120)
    //                    .offset(y:50)
                    
                    Spacer()
                }
                .overlay{
                    LoadingView(show: $isLoading)
                }
                .photosPicker(isPresented: $showImagePicker, selection: $photoItem)

                .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Error"),
                                message: Text(errorMessage),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                .onChange(of: photoItem){
                    newvalue in
                    if let newvalue{
                        Task{
                            if let rawImageData = try? await newvalue.loadTransferable(type: Data.self),
                               let image = UIImage(data: rawImageData),
                               let compressedImageData =  image.jpegData(compressionQuality:0.5){
                                await MainActor.run(body: {
                                    withAnimation(.easeInOut(duration: 0.45)){
                                        postImageData = compressedImageData
                                        photoItem = nil
                                    }
                                })
                            }
                        }
                    }
                }
                
            }
        }
        
        
        
    }
    
    func Publish(){
        isLoading = true
        showkeyboard=false
        Task{
            do{
                //guard let profileURL = profileURL else { return }    ////////////////////URL  add when you are adding dp pic for every account //by ARAVIND RM
                
                let imageRefernceId = "\(userUID)\(Date())"
                let storageRef = Storage.storage().reference().child("Classified_Images").child(imageRefernceId)
                if let postImageData{
                    let _ = try await storageRef.putDataAsync(postImageData)
                    let downloadURL = try await storageRef.downloadURL()
                    let classified = Classified(Title : title, Price: price,Location: location, Description: description,imageURl: downloadURL, imageRefernceID :imageRefernceId, Negotiation: [], userProfileURL:profileURL ?? URL(string: "ASDasdas")!, userName: usernamestored, userUID: userUID)
                    try await createDocumentAtFireBase(classified)
                }else{
                    let classified = Classified(Title : title, Price: price,Location: "", Description: description, imageRefernceID :imageRefernceId, Negotiation: [], userProfileURL:profileURL ?? URL(string: "ASDasdas")!, userName: usernamestored, userUID: userUID)
                    try await createDocumentAtFireBase(classified)

                }
                
            }
            catch{
                await setError(error)
            }
        }
    }
    
    func setError(_ error : Error) async{
        await MainActor.run(body:{
            errorMessage = error.localizedDescription
            print(errorMessage)
        })
    }
    
    
    func createDocumentAtFireBase(_ classified:Classified) async throws{
        let doc = Firestore.firestore().collection("Classified").document()
        let _ = try doc.setData(from: classified, completion: {
            error in
            if error == nil{
                isLoading = false
                var updatedClassified = classified
                updatedClassified.id = doc.documentID
                onPublish(updatedClassified)
                dismiss()
            }else{
                isLoading = false
                dismiss()

            }
        })
    }
    
}
    

#Preview {
    CreateClassifiedView(onPublish: { _ in},Show: .constant(true))
}
