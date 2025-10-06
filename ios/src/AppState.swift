import Foundation
import Combine

class AppState: ObservableObject {
    @Published var currentUser: User? = nil
    @Published var expenses: [Expense] = []
    var cancellables = Set<AnyCancellable>()

    func login(email: String, password: String){
        NetworkManager.shared.login(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let err) = completion {
                    print("Login error:", err)
                }
            } receiveValue: { user in
                self.currentUser = user
                self.fetchExpenses()
            }.store(in: &cancellables)
    }

    func signup(name: String, email: String, password: String){
        let user = User(id: nil, name: name, email: email, password: password)
        NetworkManager.shared.signup(user: user)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let err) = completion { print("Signup err", err) }
            } receiveValue: { created in
                self.currentUser = created
                self.fetchExpenses()
            }.store(in: &cancellables)
    }

    func fetchExpenses(){
        guard let uid = currentUser?.id else { return }
        NetworkManager.shared.fetchExpenses(userId: uid)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let err) = completion { print("fetch err", err) }
            } receiveValue: { arr in
                self.expenses = arr
            }.store(in: &cancellables)
    }

    func addExpense(amount: Double, description: String, date: Date){
        guard let uid = currentUser?.id else { return }
        let iso = ISO8601DateFormatter().string(from: date)
        let e = Expense(id: nil, userId: uid, amount: amount, description: description, category: nil, date: iso, receiptUrl: nil)
        NetworkManager.shared.addExpense(e)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let err) = completion { print("add err", err) }
            } receiveValue: { expense in
                self.expenses.insert(expense, at: 0)
            }.store(in: &cancellables)
    }
}
