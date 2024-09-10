//
//  ViewController.m
//  Project-Demo
//
//  Created by kaushik.bha on 04/09/24.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Project_Demo-Swift.h"

@interface ViewController ()
@property (strong, nonatomic) NSString *selectedCityName;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar.layer.cornerRadius = 10.0;
    self.searchBar.clipsToBounds = YES;
    
    self.weatherButton.layer.cornerRadius = 10.0;
    self.weatherButton.clipsToBounds = YES;
    
}

- (NSManagedObjectContext *)managedObjectContext {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.persistentContainer.viewContext;
}


- (IBAction)getWeather:(id)sender {
    NSString *cityName = self.searchBar.text;
    if (cityName.length > 0) {
        [[CoreDataManager shared] fetchCityWithName:cityName completion:^(City * _Nullable city) {
            if (city) {
                NSLog(@"City found: %@", city.name);
                self.selectedCityName = cityName;
                [self performSegueWithIdentifier:@"showWeather" sender:self];
            } else {
                NSLog(@"City not found.");
                [self showAlertWithTitle:Messages.CITY_NOT_FOUND message:Messages.CITY_NOT_FOUND_MESSAGE];
            }
        }];
    } else {
        NSLog(@"Please enter a city name.");
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showWeather"]) {
        DetailCollectionViewController *destinationVC = segue.destinationViewController;
        destinationVC.cityName = self.selectedCityName; // Pass the city name
    }
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                         style:UIAlertActionStyleDefault
                                                       handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
