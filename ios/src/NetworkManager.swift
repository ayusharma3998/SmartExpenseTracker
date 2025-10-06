import Foundation
import Combine

class NetworkManager: ObservableObject {
    static let shared = NetworkManager()
    private init(){}
    let baseURL = "http://localhost:8080/api"

    func signup(user: User) -> AnyPublisher<User, Error> {
        guard let url = URL(string: "\(baseURL)/users") else { fatalError() }
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = try? JSONEncoder().encode(user)
        return URLSession.shared.dataTaskPublisher(for: req)
            .map(\.data)
            .decode(type: User.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func login(email: String, password: String) -> AnyPublisher<User, Error> {
        guard let url = URL(string: "\(baseURL)/login") else { fatalError() }
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = ["email": email, "password": password]
        req.httpBody = try? JSONEncoder().encode(body)
        return URLSession.shared.dataTaskPublisher(for: req)
            .map(\.data)
            .decode(type: User.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func fetchExpenses(userId: String) -> AnyPublisher<[Expense], Error> {
        guard let url = URL(string: "\(baseURL)/expenses?userId=\(userId)") else { fatalError() }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Expense].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func addExpense(_ e: Expense) -> AnyPublisher<Expense, Error> {
        guard let url = URL(string: "\(baseURL)/expenses") else { fatalError() }
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = try? JSONEncoder().encode(e)
        return URLSession.shared.dataTaskPublisher(for: req)
            .map(\.data)
            .decode(type: Expense.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func categorize(text: String) -> AnyPublisher<[String:String], Error> {
        guard let url = URL(string: "\(baseURL)/categorize") else { fatalError() }
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = try? JSONEncoder().encode(["text": text])
        return URLSession.shared.dataTaskPublisher(for: req)
            .map(\.data)
            .decode(type: [String:String].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
