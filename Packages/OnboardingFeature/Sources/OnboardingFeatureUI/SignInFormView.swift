import SwiftUI

struct SignInFormView: View {
    private enum Field: Hashable {
        case email
        case password
    }

    let showActivityIndicator: Bool
    let onSignIn: (String, String) -> Void

    @State private var email = ""
    @State private var password = ""
    @FocusState private var focusedField: Field?
    private var continueButtonOpacity: Double {
        if showActivityIndicator {
            return 0
        } else if email.isEmpty || password.isEmpty {
            return 0.6
        } else {
            return 1
        }
    }

    var body: some View {
        VStack {
            TextField("E-mail", text: $email)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .textFieldStyle(.roundedBorder)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .focused($focusedField, equals: .email)
                .disabled(showActivityIndicator)
            SecureField("Password", text: $password)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .textFieldStyle(.roundedBorder)
                .textContentType(.password)
                .focused($focusedField, equals: .password)
                .disabled(showActivityIndicator)
            HStack {
                Spacer()
                ZStack(alignment: .trailing) {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .opacity(showActivityIndicator ? 1 : 0)
                        .tint(.white)
                        .scaleEffect(0.8)
                    Button {
                        focusedField = nil
                        onSignIn(email, password)
                    } label: {
                        HStack(spacing: 3) {
                            Text("Continue")
                                .font(.callout.bold())
                            Image(systemName: "chevron.compact.right")
                                .font(.callout)
                                .offset(y: 1)
                        }
                        .padding(.trailing, 2)
                    }
                    .tint(.white)
                    .opacity(continueButtonOpacity)
                    .allowsHitTesting(!email.isEmpty && !password.isEmpty)
                }
            }
        }
        .padding([.leading, .trailing], 75)
    }
}

#Preview("Continue", traits: .sizeThatFitsLayout) {
    SignInFormView(showActivityIndicator: false) { _, _ in }
        .padding()
        .background(.black)
}

#Preview("Activity Indicator", traits: .sizeThatFitsLayout) {
    SignInFormView(showActivityIndicator: true) { _, _ in }
        .padding()
        .background(.black)
}
