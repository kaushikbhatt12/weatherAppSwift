import UIKit

protocol SignupViewControllerProtocol : AnyObject {
    func invalidInput() -> Void
    func failedWithError(_ error : Error) -> Void
    func signUpSucceded() -> Void
}

class SignupViewController: UIViewController,SignupViewControllerProtocol {

    private var emailTextField: UITextField!
    private var passwordTextField: UITextField!
    private var signUpButton: UIButton!
    
    var viewModel: SignupViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        // Set up UI elements
        setupUI()
    }

    private func setupUI() {
        // Back button
        let crossButton = UIButton(type: .system)
        crossButton.frame = CGRect(x: 20, y: 40, width: 40, height: 40)
        crossButton.setTitle(AppConstants.BACK_ICON, for: .normal)
        crossButton.addTarget(self, action: #selector(crossButtonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(crossButton)
        
        // Email Text Field
        emailTextField = UITextField(frame: CGRect(x: 40, y: 150, width: self.view.frame.size.width - 80, height: 40))
        emailTextField.placeholder = Messages.ENTER_EMAIL
        emailTextField.borderStyle = .roundedRect
        emailTextField.autocapitalizationType = .none
        self.view.addSubview(emailTextField)
        
        // Password Text Field
        passwordTextField = UITextField(frame: CGRect(x: 40, y: 200, width: self.view.frame.size.width - 80, height: 40))
        passwordTextField.placeholder = Messages.ENTER_PASSWORD
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        self.view.addSubview(passwordTextField)
        
        // Sign Up Button
        signUpButton = UIButton(type: .system)
        signUpButton.frame = CGRect(x: 40, y: 260, width: self.view.frame.size.width - 80, height: 40)
        signUpButton.setTitle(Messages.SIGNUP, for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.backgroundColor = .systemBlue
        signUpButton.layer.cornerRadius = 5
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(signUpButton)
    }
    
    // Action for Sign Up Button
    @objc private func signUpButtonTapped(_ sender: UIButton) {
        self.viewModel?.signup(email: emailTextField.text ?? "", password:passwordTextField.text ?? "")
    }
    
    // Present HomeViewController
    private func presentHomeViewController() {
        let storyboard = UIStoryboard(name: AppConstants.STORY_BOARD_NAME, bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: AppConstants.HOME_NAVIGATION_VIEW_CONTROLLER)
        homeVC.modalPresentationStyle = .fullScreen
        self.present(homeVC, animated: true, completion: nil)
    }
    
    // Action for Back Button
    @objc private func crossButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Show Alert
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Messages.OK, style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func invalidInput() {
        showAlert(title: Messages.ERROR, message: Messages.ENTER_EMAIL_AND_PASSWORD)
    }
    
    func signUpSucceded() {
        presentHomeViewController()
    }
    
    func failedWithError(_ error: Error) {
        showAlert(title: Messages.ERROR, message: error.localizedDescription)
    }
}

