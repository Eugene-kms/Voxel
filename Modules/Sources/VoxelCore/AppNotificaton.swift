import Foundation

public enum AppNotificaton: String {
    case didLoginSuccessfully
    case didLogout
}

public extension NotificationCenter {
    
    func post(_ appNotification: AppNotificaton) {
        NotificationCenter.default.post(
            Notification(name: Notification.Name(appNotification.rawValue)))
    }
}
