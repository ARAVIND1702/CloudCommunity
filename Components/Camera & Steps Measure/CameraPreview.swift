import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    var session: AVCaptureSession

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        addPreviewLayer(to: view)
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // Perform updates in the background without blocking the camera
        DispatchQueue.global(qos: .background).async {
            // Update UI elements here
            
            // Example: Modify subviews, update labels, etc.
            // uiView.subviews.forEach { $0.removeFromSuperview() }
            // let newSubview = ...
            // uiView.addSubview(newSubview)
            
            // Note: Make sure to perform UI updates on the main queue if needed.
            // Example: DispatchQueue.main.async { /* Update UI here */ }
        }
    }
    
    private func addPreviewLayer(to view: UIView) {
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.layer.bounds
        view.layer.addSublayer(previewLayer)
    }
}
