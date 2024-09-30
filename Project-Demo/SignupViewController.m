#import "SignupViewController.h"

@interface SignupViewController ()

@property (strong, nonatomic) UITextField *emailTextField;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (strong, nonatomic) UIButton *signUpButton;
@property (strong, nonatomic) UIButton *backButton;

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Set up the UI elements
    [self setupUI];
}

- (void)setupUI {
    // Back button
    UIButton *crossButton = [UIButton buttonWithType:UIButtonTypeSystem];
    crossButton.frame = CGRectMake(20, 40, 40, 40);
    [crossButton setTitle:AppConstants.BACK_ICON forState:UIControlStateNormal]; 
    [crossButton addTarget:self action:@selector(crossButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:crossButton];
    
    // Email Text Field
    self.emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, 150, self.view.frame.size.width - 80, 40)];
    self.emailTextField.placeholder = Messages.ENTER_EMAIL;
    self.emailTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.emailTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:self.emailTextField];
    
    // Password Text Field
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, 200, self.view.frame.size.width - 80, 40)];
    self.passwordTextField.placeholder = Messages.ENTER_PASSWORD;
    self.passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordTextField.secureTextEntry = YES;
    [self.view addSubview:self.passwordTextField];
    
    // Login Button
    self.signUpButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.signUpButton.frame = CGRectMake(40, 260, self.view.frame.size.width - 80, 40);
    [self.signUpButton setTitle:Messages.SIGNUP forState:UIControlStateNormal];
    [self.signUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.signUpButton.backgroundColor = [UIColor systemBlueColor];
    self.signUpButton.layer.cornerRadius = 5;
    [self.signUpButton addTarget:self action:@selector(signUpButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.signUpButton];
}

// Action for Login Button
- (void)signUpButtonTapped:(id)sender {
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    
    if (email.length == 0 || password.length == 0) {
        [self showAlertWithTitle:Messages.ERROR message:Messages.ENTER_EMAIL_AND_PASSWORD];
    } else {
        [FirebaseAuthManager.shared signUpWithEmail:email password:password completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
            if(error){
                [self showAlertWithTitle:Messages.ERROR message:error.localizedDescription];
            } else {
                [self presentHomeViewController];
            }
        }];
    }
}

- (void)presentHomeViewController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:AppConstants.STORY_BOARD_NAME bundle:nil];
    HomeViewController *homeVC = [storyboard instantiateViewControllerWithIdentifier:AppConstants.HOME_NAVIGATION_VIEW_CONTROLLER];
    homeVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:homeVC animated:YES completion:nil];
}


- (void)crossButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:Messages.OK
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
