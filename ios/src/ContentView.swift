import SwiftUI

struct ContentView: View {
    @StateObject var store = AppState()
    @State private var showSplash = true

    var body: some View {
        ZStack {
            if store.currentUser == nil {
                LoginView().environmentObject(store)
            } else {
                MainTabView().environmentObject(store)
            }

            if showSplash {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            withAnimation { showSplash = false }
                        }
                    }
            }
        }
    }
}
