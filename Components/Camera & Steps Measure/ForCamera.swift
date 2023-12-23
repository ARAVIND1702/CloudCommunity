import AVFoundation

class CameraViewModel: NSObject, ObservableObject {
    var session: AVCaptureSession = AVCaptureSession()

    override init() {
        super.init()

        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }

                let output = AVCaptureVideoDataOutput()
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }

                session.startRunning()
            } catch {
                print("Error setting up camera: \(error.localizedDescription)")
            }
        }
    }

    func checkCameraAuthorization() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            // Camera access is already granted.
            break
        case .notDetermined:
            // Request camera access.
            AVCaptureDevice.requestAccess(for: .video) { _ in }
        case .denied, .restricted:
            // Camera access is denied or restricted.
            // Handle this scenario appropriately (e.g., show a prompt to enable camera access in settings).
            break
        @unknown default:
            break
        }
    }
}
