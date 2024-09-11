//
//  WeatherModel.h
//  Project-Demo
//
//  Created by kaushik.bha on 11/09/24.
//

#import <Foundation/Foundation.h>
#import "WeatherModelDelegate.h"
#import "Project_Demo-Swift.h"

@interface WeatherModel : NSObject

@property (weak, nonatomic) id<WeatherModelDelegate> delegate;

- (void)fetchCityDataWithName:(NSString *)cityName;

@end

