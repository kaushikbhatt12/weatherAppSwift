//
//  ViewController.m
//  Project-Demo
//
//  Created by kaushik.bha on 04/09/24.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "WeatherModel.h"

@interface ViewController () <WeatherModelDelegate>

@property (strong, nonatomic) NSString *selectedCityName;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) WeatherModel *weatherModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar.layer.cornerRadius = 10.0;
    self.searchBar.clipsToBounds = YES;
    
    self.weatherButton.layer.cornerRadius = 10.0;
    self.weatherButton.clipsToBounds = YES;
    
    // Initialize the model and set the delegate
    self.weatherModel = [[WeatherModel alloc] init];
    self.weatherModel.delegate = self;
}


- (IBAction)getWeather:(id)sender {
    NSString *cityName = self.searchBar.text;
    if (cityName.length > 0) {
        // Delegate the task to the model
        [self.weatherModel fetchCityDataWithName:cityName];
    } else {
        NSLog(@"Please enter a city name.");
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:AppConstants.SHOW_WEATHER]) {
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

- (void)didFetchCityData:(City * _Nullable)city {
    if (city) {
        NSLog(@"City found: %@", city.name);
        self.selectedCityName = city.name;
        self.longitude = @(city.longitude);
        self.latitude = @(city.latitude);
        [self performSegueWithIdentifier:AppConstants.SHOW_WEATHER sender:self];
    }
}

- (void)didFailWithError:(NSError * _Nonnull)error {
    NSLog(@"Error: %@", error.localizedDescription);
    [self showAlertWithTitle:Messages.ERROR message:error.localizedDescription];
}

@end
