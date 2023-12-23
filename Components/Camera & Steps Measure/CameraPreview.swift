import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    var session: AVCaptureSession

    func makeUIView(context: Context) -> UIView {
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        let view = UIView(frame: UIScreen.main.bounds)
        previewLayer.frame = view.layer.bounds
        view.layer.addSublayer(previewLayer)
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
