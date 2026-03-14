#if canImport(SwiftUI)
import SwiftUI

public struct AccountPrivacyView: View {
    @StateObject private var permissions = PermissionService()

    public init() {}

    public var body: some View {
        NavigationStack {
            List {
                Section("Account") {
                    Label("Profile", systemImage: "person.text.rectangle")
                    Label("Subscription & Billing", systemImage: "creditcard")
                    Label("Connected Email & Phone", systemImage: "link")
                }

                Section("Privacy Controls") {
                    ForEach(UserPermission.allCases) { permission in
                        HStack {
                            Text(permission.title)
                            Spacer()
                            if permissions.hasAccess(permission) {
                                Text("Granted")
                                    .foregroundStyle(.green)
                            } else {
                                Button("Allow") {
                                    permissions.request(permission)
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                    }
                }

                Section("Data Safety") {
                    Text("Mac only acts on approved tasks and keeps data scoped to your account and privacy settings.")
                }
            }
            .navigationTitle("Account & Privacy")
        }
    }
}
#endif
