import SwiftUI

struct LoginView: View {
    @EnvironmentObject var store: AppState
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    @State private var signupMode = false

    var body: some View {
        NavigationView {
            VStack(spacing:16){
                Text(signupMode ? "Create your account" : "Welcome back")
                    .font(.title).bold()
                if signupMode {
                    TextField("Full name", text: $name)
                        .padding().background(.ultraThinMaterial).cornerRadius(10)
                }
                TextField("Email", text: $email).keyboardType(.emailAddress)
                    .padding().background(.ultraThinMaterial).cornerRadius(10)
                SecureField("Password", text: $password)
                    .padding().background(.ultraThinMaterial).cornerRadius(10)
                Button(action: {
                    if signupMode {
                        store.signup(name: name, email: email, password: password)
                    } else {
                        store.login(email: email, password: password)
                    }
                }) {
                    Text(signupMode ? "Sign up" : "Login")
                        .frame(maxWidth:.infinity)
                        .padding().background(Color("emerald")).foregroundColor(.white).cornerRadius(12)
                }

                Button(action:{ signupMode.toggle() }) {
                    Text(signupMode ? "Have an account? Login" : "Don't have an account? Sign up")
                        .font(.footnote).foregroundColor(.gray)
                }

                Spacer()
            }.padding()
        }
    }
}
