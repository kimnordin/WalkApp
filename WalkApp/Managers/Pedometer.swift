//
//  Pedometer.swift
//  WalkApp
//
//  Created by Kim Nordin on 2022-07-10.
//

import CoreMotion

struct Pedometer {
    private let pedometer = CMPedometer()

    private var isPedometerAvailable: Bool {
        return CMPedometer.isPedometerEventTrackingAvailable() &&
            CMPedometer.isDistanceAvailable() && CMPedometer.isStepCountingAvailable()
    }

    func countSteps(from: Date, to: Date, returnData: @escaping (Double) -> Void) {
        if isPedometerAvailable {
            pedometer.queryPedometerData(from: from, to: to) { pedometerData, error in
                guard let pedometerData = pedometerData, error == nil else { return }
                DispatchQueue.main.async {
                    if let returnedData = pedometerData.distance?.doubleValue {
                        returnData(returnedData)
                    }
                }
            }
        }
    }

    func startPedometer(from: Date, returnData: @escaping (Double) -> Void) {
        if isPedometerAvailable {
            pedometer.startUpdates(from: from) { pedometerData, error in
                guard let pedometerData = pedometerData, error == nil else { return }
                DispatchQueue.main.async {
                    if let returnedData = pedometerData.distance?.doubleValue {
                        returnData(returnedData)
                    }
                }
            }
        }
    }

    func stopPedometer() {
        pedometer.stopUpdates()
    }
}
