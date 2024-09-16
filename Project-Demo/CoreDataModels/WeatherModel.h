#import <Foundation/Foundation.h>
#import "WeatherModelDelegate.h"
#import "Project_Demo-Swift.h"

@interface WeatherModel : NSObject

@property (weak, nonatomic) id<WeatherModelDelegate> delegate;

- (void)fetchCityDataWithName:(NSString *)cityName;

@end

