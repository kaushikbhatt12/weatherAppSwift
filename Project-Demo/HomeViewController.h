#import <UIKit/UIKit.h>
#import "Project_Demo-Swift.h"

@interface HomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UIButton *weatherButton;

@property (weak, nonatomic) IBOutlet UIButton *getWeatherButton;


- (IBAction)getWeather:(id)sender;

@end

