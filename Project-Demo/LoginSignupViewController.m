#import "LoginSignupViewController.h"

@interface LoginSignupViewController ()

@end

@implementation LoginSignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginButton.layer.cornerRadius = LAYOUT_CONSTANTS.CORNER_RADIUS;
    self.loginButton.clipsToBounds = YES;
    self.signUp.layer.cornerRadius = LAYOUT_CONSTANTS.CORNER_RADIUS;
    self.signUp.clipsToBounds = YES;
}

- (IBAction)signUp:(id)sender {
    SignupViewController *signupVC = [[SignupViewController alloc] init];
    signupVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:signupVC animated:YES completion:nil];
}

- (IBAction)login:(id)sender {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    loginVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:loginVC animated:YES completion:nil];
}

@end
