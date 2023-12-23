import SwiftUI

struct CameraView: View {
    @ObservedObject var cameraManager = CameraManager()

    var body: some View {
        VStack {
            // Add your camera preview layer here
            // For example, if you have a CameraPreview struct:
            CameraPreview(session: cameraManager.session)
            
        }
        .onAppear {
            self.cameraManager.startSession()
        }
        .onDisappear {
            self.cameraManager.stopSession()
        }
    }
}



