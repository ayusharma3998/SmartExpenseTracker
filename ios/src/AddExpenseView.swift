import SwiftUI
import Combine

struct AddExpenseView: View {
    @EnvironmentObject var store: AppState
    @Environment(\.dismiss) var dismiss
    @State private var amountText = ""
    @State private var description = ""
    @State private var date = Date()
    @State private var suggestedCategory: String?
    var cancellable: AnyCancellable?

    var body: some View {
        NavigationView {
            Form {
                TextField("Amount (₹)", text: $amountText).keyboardType(.decimalPad)
                TextField("Description", text: $description)
                DatePicker("Date", selection: $date, displayedComponents: .date)

                if let cat = suggestedCategory {
                    Text("Suggested: \(cat)").foregroundColor(.blue)
                }

                Button("Suggest Category (AI)") {
                    cancellable = NetworkManager.shared.categorize(text: description)
                        .receive(on: DispatchQueue.main)
                        .sink { completion in
                            if case .failure(let err) = completion { print("cat err", err) }
                        } receiveValue: { map in
                            self.suggestedCategory = map["category"]
                        }
                }

                Button("Save") {
                    guard let amt = Double(amountText), let uid = store.currentUser?.id else { return }
                    let expense = Expense(id: nil, userId: uid, amount: amt, description: description, category: suggestedCategory, date: ISO8601DateFormatter().string(from: date), receiptUrl: nil)
                    store.addExpense(amount: amt, description: description, date: date)
                    dismiss()
                }.disabled(amountText.isEmpty || description.isEmpty)
            }
            .navigationTitle("Add Expense")
            .toolbar { ToolbarItem(placement:.cancellationAction) { Button("Cancel"){dismiss()} } }
        }
    }
}
