#import "WeatherModel.h"

@implementation WeatherModel

- (void)fetchCityDataWithName:(NSString *)cityName {
    if (cityName.length > 0) {
        // Perform the network or Core Data fetch in a background queue
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [[WeatherDataManager shared] getCityDataWithName:cityName completion:^(City * _Nullable city) {
                // Switch back to the main thread 
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (city) {
                        [self.delegate didFetchCityData:city];
                    } else {
                        NSError *error = [NSError errorWithDomain:AppConstants.CITY_NOT_FOUND
                                                             code:404
                                                         userInfo:@{NSLocalizedDescriptionKey: Messages.CITY_NOT_FOUND}];
                        [self.delegate didFailWithError:error];
                    }
                });
            }];
        });
    }
}

@end

