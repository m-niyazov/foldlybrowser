//
//  AmplitudeAnalyticService.swift
//  Volty+
//
//  Created by m-niyazov on 31.05.2023.
//

import AmplitudeSwift

final class AmplitudeAnalyticService: AnalyticService {
    let amplitude = Amplitude(configuration: Configuration(
        apiKey: AppConstants.amplitudeApiKey,
        autocapture: .all
    ))
    func send(event: String, params: [[String: String]]? = nil) {
        let parameters = params ?? []
        let eventName = "amp_" + event
        var flatParameters: [String: Any] = [:]

        parameters.forEach { parammPair in
            parammPair.forEach { key, value in
                flatParameters[key] = value
            }
        }

        amplitude.track(eventType: eventName, eventProperties: flatParameters)
        print("AMPLITUDE LOG:", eventName, flatParameters.isEmpty ? "" : flatParameters)
    }

    func setUserIdentify(key: String, value: String) {
        let identify = Identify()
        identify.set(property: key, value: value)
        amplitude.identify(identify: identify)
    }
}
