import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("emerald"), Color("midnight")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack(spacing:20){
                Image(systemName: "wallet.pass")
                    .resizable()
                    .scaledToFit()
                    .frame(width:100,height:100)
                Text("Smart Expense Tracker")
                    .font(.title).bold().foregroundColor(.white)
                Text("Track Smarter. Spend Better.")
                    .foregroundColor(.white.opacity(0.9))
            }
        }
    }
}
