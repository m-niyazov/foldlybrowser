import UserNotifications

final class NotificationsPermissionService: PermissionService {
    private let analyticService: CompositionalAnalyticService

    init(analyticService: CompositionalAnalyticService) {
        self.analyticService = analyticService
    }

     func isGrantedAccess() async -> Bool {
        let notificationCenter = UNUserNotificationCenter.current()
        let settings = await notificationCenter.notificationSettings()
        return settings.authorizationStatus == .authorized
    }

    func request() async -> PermissionStatus {
        let notificationCenter = UNUserNotificationCenter.current()
        let notificationSettings = await notificationCenter.notificationSettings()
        let isPermissionAlreadyRequested = notificationSettings.authorizationStatus == .denied
        let request = try? await notificationCenter.requestAuthorization(options: [.alert, .sound, .badge])

        if request == true {
            analyticService.selectNotifyPushStatus(status: true)
            return .authorized
        } else if isPermissionAlreadyRequested {
            analyticService.selectNotifyPushStatus(status: false)
            return .denied
        } else {
            analyticService.selectNotifyPushStatus(status: false)
            return .notDetermined
        }
    }
}
