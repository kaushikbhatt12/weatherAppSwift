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

    // Do any additional setup after loading the view.
    
}

- (NSManagedObjectContext *)managedObjectContext {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.persistentContainer.viewContext;
}


- (IBAction)getWeather:(id)sender {
    NSString *cityName = self.searchBar.text;
    if (cityName.length > 0) {
        [self checkCityInCoreData:cityName];
    } else {
        // Handle empty search input if needed
        NSLog(@"Please enter a city name.");
    }
}

- (void)checkCityInCoreData:(NSString *)cityName {
    NSManagedObjectContext *context = [self managedObjectContext];

    // Convert both cityName and stored names to lowercase for case-insensitive comparison
    NSString *lowercaseCityName = [cityName lowercaseString];

    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"City"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", lowercaseCityName];
    fetchRequest.predicate = predicate;

    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:fetchRequest error:&error];


    if (error) {
        NSLog(@"Error fetching city: %@, %@", error, error.userInfo);
        return;
    }

    if (results.count > 0) {
        NSLog(@"City %@ found in Core Data.", cityName);
        self.selectedCityName = cityName;
        [self performSegueWithIdentifier:@"showWeather" sender:self];
//        [self fetchWeatherForCity:cityName];  // Fetch weather data for the city
    } else {
        NSLog(@"City %@ not found in Core Data.", cityName);
        // Handle city not found, e.g., show an alert or make an API call
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showWeather"]) {
        DetailCollectionViewController *destinationVC = segue.destinationViewController;
        destinationVC.cityName = self.selectedCityName; // Pass the city name
    }
}




@end
