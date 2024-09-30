import UIKit

protocol LoginViewControllerProtocol : AnyObject {
    func invalidInput() -> Void
    func failedWithError(_ error : Error) -> Void
    func logInSucceded() -> Void
}

class LoginViewController: UIViewController,LoginViewControllerProtocol {

    private var emailTextField: UITextField!
    private var passwordTextField: UITextField!
    private var loginButton: UIButton!
    private var backButton: UIButton!
    
    var viewModel: LoginViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        // Set up the UI elements
        setupUI()
    }

    private func setupUI() {
        // Cross Button
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
        
        // Login Button
        loginButton = UIButton(type: .system)
        loginButton.frame = CGRect(x: 40, y: 260, width: self.view.frame.size.width - 80, height: 40)
        loginButton.setTitle(Messages.LOGIN, for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .systemBlue
        loginButton.layer.cornerRadius = 5
        loginButton.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(loginButton)
    }

    // Action for Login Button
    @objc private func loginButtonTapped(_ sender: UIButton) {
        self.viewModel?.login(email: emailTextField.text ?? "", password:passwordTextField.text ?? "")
    }

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

    private func showAlert(withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Messages.OK, style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func invalidInput() {
        showAlert(withTitle: Messages.ERROR, message: Messages.ENTER_EMAIL_AND_PASSWORD)
    }
    
    func logInSucceded() {
        presentHomeViewController()
    }
    
    func failedWithError(_ error: Error) {
        showAlert(withTitle: Messages.ERROR, message: error.localizedDescription)
    }
}
