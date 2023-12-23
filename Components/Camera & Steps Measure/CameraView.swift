import SwiftUI
import AVFoundation
import UIKit

struct CameraView: View {
    @ObservedObject var cameraViewModel = CameraViewModel()

    var body: some View {
        ZStack {
                 CameraPreview(session: cameraViewModel.session)
                     .edgesIgnoringSafeArea(.all)

                 Text("Your Overlay Text")
                     .foregroundColor(.white)
                     .font(.largeTitle)
                     .padding()
             }
             .onAppear {
                 cameraViewModel.checkCameraAuthorization()
             }
    }

   
}
