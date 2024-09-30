#import <UIKit/UIKit.h>
#import "Project_Demo-Swift.h"
#import "LoginViewController.h"
#import "SignupViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginSignupViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signUp;

- (IBAction)login:(id)sender;
- (IBAction)signUp:(id)sender;

@end

NS_ASSUME_NONNULL_END
