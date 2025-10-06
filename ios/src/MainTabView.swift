import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var store: AppState

    var body: some View {
        TabView {
            DashboardView().tabItem { Label("Home", systemImage:"house") }
            Text("Analytics").tabItem { Label("Analytics", systemImage:"chart.bar") }
            InsightsView().tabItem { Label("Insights", systemImage:"sparkles") }
            SettingsView().tabItem { Label("Settings", systemImage:"gear") }
        }
    }
}
