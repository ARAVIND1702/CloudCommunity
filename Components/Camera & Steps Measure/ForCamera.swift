import AVFoundation

class CameraManager: NSObject, ObservableObject {
     let session = AVCaptureSession()

    override init() {
        super.init()
        setupCamera()
    }

    private func setupCamera() {
        session.sessionPreset = .high

        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            print("Camera not available.")
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            if session.canAddInput(input) {
                session.addInput(input)
            }

            let output = AVCaptureVideoDataOutput()
            output.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: .userInitiated))

            if session.canAddOutput(output) {
                session.addOutput(output)
            }
        } catch {
            print("Error setting up camera: \(error.localizedDescription)")
        }
    }

    func startSession() {
        if !session.isRunning {
            session.startRunning()
        }
    }

    func stopSession() {
        if session.isRunning {
            session.stopRunning()
        }
    }
}

extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // Process the video frame asynchronously on a background queue
        DispatchQueue.global(qos: .userInitiated).async {
            // Your frame processing logic goes here
            // This code is executed on a background queue
        }
    }
}
