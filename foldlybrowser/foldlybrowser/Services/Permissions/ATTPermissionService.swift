import AppTrackingTransparency
import ApphudSDK
import AdSupport.ASIdentifierManager
import UIKit
//import FacebookCore

final class ATTPermissionService: PermissionService {
    private let analyticService: CompositionalAnalyticService

    init(analyticService: CompositionalAnalyticService) {
        self.analyticService = analyticService
    }

    func isGrantedAccess() async -> Bool {
        ATTrackingManager.trackingAuthorizationStatus == .authorized
    }

    func request() async -> PermissionStatus {
        guard ATTrackingManager.trackingAuthorizationStatus == .notDetermined else {
            return await isGrantedAccess() ? .authorized : .denied
        }
        analyticService.shownAttRequest()
        return await withCheckedContinuation { continuation in
            ATTrackingManager.requestTrackingAuthorization { result in
                Task {
                    switch result {
                    case .authorized:
                        self.analyticService.selectAttStatus(status: true)
                        let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                        let idfv = await self.getIDFV()
                        Apphud.setDeviceIdentifiers(idfa: idfa, idfv: idfv)
//                        Settings.shared.isAutoLogAppEventsEnabled = true
//                        if #unavailable(iOS 17) {
//                            Settings.shared.isAdvertiserTrackingEnabled = true
//                        }
//                        Settings.shared.isAdvertiserIDCollectionEnabled = true
                        continuation.resume(returning: .authorized)
                    default:
                        self.analyticService.selectAttStatus(status: false)
//                        Settings.shared.isAutoLogAppEventsEnabled = false
//                        if #unavailable(iOS 17) {
//                            Settings.shared.isAdvertiserTrackingEnabled = true
//                        }
//                        Settings.shared.isAdvertiserIDCollectionEnabled = false
                        continuation.resume(returning: .denied)
                    }
                }
            }
        }
    }

    @MainActor
    func getIDFV() async -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
}
