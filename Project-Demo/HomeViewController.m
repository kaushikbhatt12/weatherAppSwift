#import "HomeViewController.h"
#import "AppDelegate.h"
#import "WeatherModel.h"

@interface HomeViewController () <WeatherModelDelegate>

@property (strong, nonatomic) NSString *selectedCityName;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) WeatherModel *weatherModel;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar.layer.cornerRadius = LAYOUT_CONSTANTS.CORNER_RADIUS;
    self.searchBar.clipsToBounds = YES;
    
    self.weatherButton.layer.cornerRadius = LAYOUT_CONSTANTS.CORNER_RADIUS;
    self.weatherButton.clipsToBounds = YES;
    
    // Initialize the model and set the delegate
    self.weatherModel = [[WeatherModel alloc] init];
    self.weatherModel.delegate = self;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.getWeatherButton.enabled = YES;
    
    NSString *title = CELL_LABEL_TEXT.GET_WEATHER;
    NSDictionary *attributes = @{
        NSFontAttributeName: [UIFont fontWithName:AppConstants.FONT_STYLE size:AppConstants.FONT_SIZE],
    };
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attributes];
    [self.weatherButton setAttributedTitle:attributedTitle forState:UIControlStateNormal];
}

- (IBAction)getWeather:(id)sender {
    NSString *cityName = self.searchBar.text;
    if (cityName.length > 0) {
        if (!self.getWeatherButton.enabled) {
            return;
        }
        self.getWeatherButton.enabled = false;
        // Delegate the task to the model
        [self.weatherModel fetchCityDataWithName:cityName];
    } else {
        NSLog(@"Please enter a city name.");
        [self showAlertWithTitle:Messages.ERROR message:Messages.NO_CITY_ENTERED];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:AppConstants.SHOW_WEATHER]) {
        DetailCollectionViewController *destinationVC = (DetailCollectionViewController *)segue.destinationViewController;
        
        DetailCollectionViewModel * viewModel = [[DetailCollectionViewModel alloc] init];
        
        destinationVC.viewModel = viewModel;
        viewModel.view = destinationVC;
        
        destinationVC.cityName = self.selectedCityName;
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
    self.getWeatherButton.enabled = YES;
    [self showAlertWithTitle:Messages.ERROR message:error.localizedDescription];
}

@end
