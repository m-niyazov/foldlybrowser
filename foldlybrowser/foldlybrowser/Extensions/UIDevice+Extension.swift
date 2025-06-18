//
//  UIDeviceExtension.swift
//

import UIKit
import DeviceKit

extension Device {
    static var isScreen4_7: Bool {
        let groupOfAllowedDevices: [Device] = [
            .iPhone6,
            .simulator(.iPhone6),
            .iPhone6s,
            .simulator(.iPhone6s),
            .iPhone7,
            .simulator(.iPhone7),
            .iPhone8,
            .simulator(.iPhone8),
            .iPhoneSE2,
            .simulator(.iPhoneSE2),
            .iPhoneSE3,
            .simulator(.iPhoneSE3)
        ] + allPads + allSimulatorPads
        return Device.current.isOneOf(groupOfAllowedDevices)
    }

    static var isScreenProMaxAndPlus: Bool {
        var groupOfAllowedDevices: [Device] = []
        groupOfAllowedDevices += allPlusSizedDevices
        groupOfAllowedDevices += allSimulatorPlusSizedDevices

        return Device.current.isOneOf(groupOfAllowedDevices)
    }

    static var isScreen12And13Mini: Bool {
        var groupOfAllowedDevices: [Device] = [
            .iPhone12Mini,
            .iPhone13Mini,
            .simulator(.iPhone12Mini),
            .simulator(.iPhone13Mini)
        ]
        return Device.current.isOneOf(groupOfAllowedDevices)
    }
}
