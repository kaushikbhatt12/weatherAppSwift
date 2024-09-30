#import <UIKit/UIKit.h>
#import "Project_Demo-Swift.h"
#import "LoginSignupViewController.h"

@interface HomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UIButton *weatherButton;

@property (weak, nonatomic) IBOutlet UIButton *getWeatherButton;

- (IBAction)logoutButtonTapped:(id)sender;

- (IBAction)getWeather:(id)sender;

@end

