import Foundation

struct User: Codable, Identifiable {
    var id: String?
    var name: String
    var email: String
    var password: String
}

struct Expense: Codable, Identifiable {
    var id: String?
    var userId: String
    var amount: Double
    var description: String
    var category: String?
    var date: String?
    var receiptUrl: String?
}
