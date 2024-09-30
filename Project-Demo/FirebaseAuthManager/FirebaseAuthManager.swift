import FirebaseAuth

@objc class FirebaseAuthManager: NSObject {

    @objc static let shared = FirebaseAuthManager()
    
    private override init() {}
    
    @objc func signUp(email: String, password: String, completion: @escaping (AuthDataResult?, NSError?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                completion(nil, error)
            } else if let authResult = authResult {
                completion(authResult, nil)
            }
        }
    }
    
    @objc func login(email: String, password: String, completion: @escaping (AuthDataResult?, NSError?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                completion(nil, error)
            } else if let authResult = authResult {
                completion(authResult, nil)
            }
        }
    }
    
    @objc func logout(completion: @escaping (NSError?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let signOutError as NSError {
            completion(signOutError)
        }
    }

    @objc func isLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    @objc func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
}
