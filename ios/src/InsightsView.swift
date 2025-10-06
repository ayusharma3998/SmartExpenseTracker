import SwiftUI

struct InsightsView: View {
    @EnvironmentObject var store: AppState
    @State private var message: String = "Loading..."

    var body: some View {
        VStack {
            Text("AI Insights").font(.title2).bold().padding()
            Text(message).padding()
            Spacer()
        }
        .onAppear {
            guard let uid = store.currentUser?.id else { return }
            NetworkManager.shared.fetchExpenses(userId: uid)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    // fallback: compute insight locally
                    if case .failure(_) = completion {
                        message = "No insights available (offline)."
                    }
                } receiveValue: { arr in
                    let byCat = Dictionary(grouping: arr, by: { $0.category ?? "Other" }).mapValues { list in
                        list.reduce(0.0) { $0 + $1.amount }
                    }
                    if let top = byCat.max(by: { $0.value < $1.value }) {
                        message = "Your top spending is on \(top.key) (₹\(Int(top.value)))."
                    } else {
                        message = "No expenses yet."
                    }
                }.cancel()
        }
    }
}
