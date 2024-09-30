import UIKit

class LoginSignupViewController: UIViewController {

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Messages.LOGIN, for: .normal)
        button.setTitleColor(.tintColor, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = LAYOUT_CONSTANTS.CORNER_RADIUS
        button.titleLabel?.font = UIFont(name: AppConstants.FONT_COPPER_PLATE, size: 27)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Messages.SIGNUP, for: .normal)
        button.setTitleColor(.tintColor, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = LAYOUT_CONSTANTS.CORNER_RADIUS
        button.titleLabel?.font = UIFont(name: AppConstants.FONT_COPPER_PLATE, size: 27)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: AppConstants.LOGIN_SIGN_UP_BACKGROUND_IMAGE) 
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        // Add background image view
        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Add login and sign-up buttons to the view
        view.addSubview(loginButton)
        view.addSubview(signUpButton)
        
        // Set constraints for login button
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Set constraints for sign-up button
        NSLayoutConstraint.activate([
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            signUpButton.widthAnchor.constraint(equalToConstant: 200),
            signUpButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Add action for buttons
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
    }

    @objc private func loginTapped() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }

    @objc private func signUpTapped() {
        let signupVC = SignupViewController()
        signupVC.modalPresentationStyle = .fullScreen
        present(signupVC, animated: true, completion: nil)
    }
}
