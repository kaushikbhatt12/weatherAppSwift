import Foundation

protocol LoginViewModelProtocol {
    func login( email: String, password: String) -> Void
}

class LoginViewModel : NSObject, LoginViewModelProtocol {
    
    weak var view : LoginViewControllerProtocol?
    
    func login(email: String, password: String) {
        if email.isEmpty || password.isEmpty {
            self.view?.invalidInput()
        }
        FirebaseAuthManager.shared.login(email: email, password: password) { authResult, error in
            if let error = error {
                self.view?.failedWithError(error)
            } else {
                self.view?.logInSucceded()
            }
        }
    }
    
}


