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
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSNumber *latitude;

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
        // Perform the network or Core Data fetch in a background queue
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [[WeatherDataManager shared] getCityDataWithName:cityName completion:^(City * _Nullable city) {
                // Switch back to the main thread for UI updates
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (city) {
                        NSLog(@"City found: %@", city.name);
                        self.selectedCityName = city.name;
                        self.longitude = @(city.longitude);
                        self.latitude = @(city.latitude);
                        [self performSegueWithIdentifier:Messages.SHOW_WEATHER sender:self];
                    } else {
                        NSLog(@"City not found.");
                        [self showAlertWithTitle:Messages.CITY_NOT_FOUND message:Messages.CITY_NOT_FOUND_MESSAGE];
                    }
                });
            }];
        });
    } else {
        NSLog(@"Please enter a city name.");
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:Messages.SHOW_WEATHER]) {
        DetailCollectionViewController *destinationVC = segue.destinationViewController;
        destinationVC.cityName = self.selectedCityName; 
        // Pass the city name latitude and longitude
        destinationVC.lon = self.longitude;
        destinationVC.lat = self.latitude;
    }
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
