#if canImport(SwiftUI)
import SwiftUI

@MainActor
public final class PermissionService: ObservableObject {
    @Published public private(set) var grantedPermissions: Set<UserPermission> = []

    public init() {}

    public func request(_ permission: UserPermission) {
        // Placeholder for platform permission prompts (UNUserNotificationCenter, EventKit, etc.)
        grantedPermissions.insert(permission)
    }

    public func hasAccess(_ permission: UserPermission) -> Bool {
        grantedPermissions.contains(permission)
    }
}
#endif
