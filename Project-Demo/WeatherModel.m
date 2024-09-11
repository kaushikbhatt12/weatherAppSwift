//
//  WeatherModel.m
//  Project-Demo
//
//  Created by kaushik.bha on 11/09/24.
//

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
                        NSError *error = [NSError errorWithDomain:@"CityNotFound"
                                                             code:404
                                                         userInfo:@{NSLocalizedDescriptionKey: @"City not found"}];
                        [self.delegate didFailWithError:error];
                    }
                });
            }];
        });
    }
}

@end

