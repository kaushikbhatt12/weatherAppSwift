#import <Foundation/Foundation.h>
#import "Project_Demo-Swift.h"

@protocol WeatherModelDelegate <NSObject>
@required
- (void)didFetchCityData:(City * _Nullable)city;
- (void)didFailWithError:(NSError * _Nonnull)error;
@end
