//
//  WeatherModelDelegate.h
//  Project-Demo
//
//  Created by kaushik.bha on 11/09/24.
//

#import <Foundation/Foundation.h>
#import "Project_Demo-Swift.h"

@protocol WeatherModelDelegate <NSObject>
@required
- (void)didFetchCityData:(City * _Nullable)city;
- (void)didFailWithError:(NSError * _Nonnull)error;
@end
