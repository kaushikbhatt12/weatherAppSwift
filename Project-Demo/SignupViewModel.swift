import Foundation

protocol SignupViewModelProtocol {
    func signup( email: String, password: String) -> Void
}

class SignupViewModel : NSObject, SignupViewModelProtocol {
    
    weak var view : SignupViewControllerProtocol?
    
    func signup(email: String, password: String) {
        if email.isEmpty || password.isEmpty {
            self.view?.invalidInput()
        }
        FirebaseAuthManager.shared.signUp(email: email, password: password) { authResult, error in
            if let error = error {
                self.view?.failedWithError(error)
            } else {
                self.view?.signUpSucceded()
            }
        }
    }
    
}


