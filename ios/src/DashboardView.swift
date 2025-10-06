import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var store: AppState
    @State private var showAdd = false

    var body: some View {
        NavigationView {
            VStack(spacing:16){
                HStack {
                    VStack(alignment:.leading){
                        Text("Good Evening,").font(.subheadline).foregroundColor(.gray)
                        Text(store.currentUser?.name ?? "User").font(.title2).bold()
                    }
                    Spacer()
                    VStack {
                        Text("Balance").font(.caption).foregroundColor(.gray)
                        Text("₹\(Int((store.expenses.map{$0.amount}.reduce(0,+) * -1) + 23450))")
                            .font(.headline).bold()
                    }
                }.padding()

                RoundedRectangle(cornerRadius:12).fill(.ultraThinMaterial).frame(height:150)
                    .overlay(Text("Category pie chart placeholder"))

                List {
                    Section(header: Text("Recent")) {
                        ForEach(store.expenses) { exp in
                            HStack {
                                Image(systemName: "creditcard")
                                VStack(alignment:.leading){
                                    Text(exp.description).font(.subheadline)
                                    Text(exp.date ?? "").font(.caption).foregroundColor(.gray)
                                }
                                Spacer()
                                Text("₹\(Int(exp.amount))")
                            }
                        }
                    }
                }
            }
            .navigationBarItems(trailing: Button(action:{ showAdd.toggle() }) {
                Image(systemName:"plus.circle.fill").font(.title)
            })
            .sheet(isPresented: $showAdd) {
                AddExpenseView().environmentObject(store)
            }
        }
    }
}
