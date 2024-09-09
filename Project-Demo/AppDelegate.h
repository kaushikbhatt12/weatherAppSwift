//
//  AppDelegate.h
//  Project-Demo
//
//  Created by kaushik.bha on 04/09/24.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppConstants.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

