//
//  RemoteConfigService.swift
//  Volty+
//
//  Created by m-niyazov on 31.05.2023.
//

import FirebaseRemoteConfig

protocol RemoteConfigService: AnyObject {
    var onboardingSettings: OnboardingRemoteSettings { get }
    var isNeedToOnbShowQuestionnaire: Bool { get }
    var selectedInAppPaywallId: String { get }
    func load() async
}

final class FirebaseRemoteConfig: RemoteConfigService {
    // MARK: - Properties
    private let remoteConfig = RemoteConfig.remoteConfig()
    let settings = RemoteConfigSettings()

    var onboardingSettings: OnboardingRemoteSettings
    var isNeedToOnbShowQuestionnaire: Bool
    var selectedInAppPaywallId: String
    var isNeedToShowNetworkTab: Bool

    // MARK: - Initialize
    init() {
        self.onboardingSettings = getDefaultOnboardingSettings()
        self.isNeedToOnbShowQuestionnaire = getDefaultIsNeedToOnbShowQuestionnaire()
        self.selectedInAppPaywallId = getDefaultSelectedInAppPaywallId()
        self.isNeedToShowNetworkTab = getDefaultIsNeedToShowNetworkTab()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }

    // MARK: - Methods
    func load() async {
        guard await fetchRemoteConfig() else {
            return
        }

        if let onboardingRemoteSettings = await loadRemoteJsonSettings(
            configId: .onboardingSettings) as OnboardingRemoteSettings? {
            self.onboardingSettings = onboardingRemoteSettings
        }

        self.isNeedToOnbShowQuestionnaire = remoteConfig.configValue(forKey: .isNeedToOnbShowQuestionnaire).boolValue

        self.selectedInAppPaywallId = remoteConfig.configValue(forKey: .selectedInAppPaywallId).stringValue
    }

    private func loadRemoteJsonSettings<T: Codable>(configId: String) async -> T? {
        await withCheckedContinuation { continuation in
            let data = remoteConfig.configValue(forKey: configId).dataValue
            let settings = try? JSONDecoder().decode(T.self, from: data)
            continuation.resume(returning: settings)
        }
    }

    private func fetchRemoteConfig() async -> Bool {
        await withCheckedContinuation { continuation in
            remoteConfig.fetchAndActivate { status, _  in
                if status == .successFetchedFromRemote || status == .successUsingPreFetchedData {
                    continuation.resume(returning: true)
                } else {
                    continuation.resume(returning: false)
                }
            }
        }
    }
}

// MARK: - DefualtSettings
private func getDefaultOnboardingSettings() -> OnboardingRemoteSettings {
    return .init(
        onboardingVersion: .v1_1,
        paywallId: "v4_1"
    )
}

private func getDefaultIsNeedToOnbShowQuestionnaire() -> Bool {
    return false
}

private func getDefaultIsNeedToShowNetworkTab() -> Bool {
    return true
}

private func getDefaultSelectedInAppPaywallId() -> String {
    return "v4_1"
}

// MARK: - Keys
private extension String {
    static let onboardingSettings = "onboarding_settings"
    static let isNeedToOnbShowQuestionnaire = "is_on_onb_questionnaire"
    static let selectedInAppPaywallId = "selected_in_app_paywallId"
}
