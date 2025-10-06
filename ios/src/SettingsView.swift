import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var store: AppState
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile")){
                    Text(store.currentUser?.name ?? "")
                    Text(store.currentUser?.email ?? "")
                }
                Button("Logout") {
                    store.currentUser = nil
                    store.expenses = []
                }.foregroundColor(.red)
            }.navigationTitle("Settings")
        }
    }
}
