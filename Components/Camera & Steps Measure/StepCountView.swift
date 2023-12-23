import SwiftUI
import CoreMotion

struct StepCountView: View {
    let pedometer = CMPedometer()
    @State private var stepCount: Int = 0
    @State var Toggle = false

    var body: some View {
        VStack {
            Text("Steps: \(stepCount)")
                .font(.largeTitle)
                .padding()
        }
        .onAppear {
            startUpdatingSteps()
        }
    }

    func startUpdatingSteps() {
        if CMPedometer.isStepCountingAvailable() {
            pedometer.startUpdates(from: Date()) { pedometerData, error in
                if let data = pedometerData {
                    DispatchQueue.main.async {
                        self.stepCount = data.numberOfSteps.intValue
                    }
                }
            }
        } else {
            // Step counting is not available on this device
            // Handle the error accordingly
            print("Step counting not available on this device.")
        }
    }
}

struct StepCountView_Previews: PreviewProvider {
    static var previews: some View {
        StepCountView()
    }
}
