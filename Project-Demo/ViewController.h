//
//  ViewController.h
//  Project-Demo
//
//  Created by kaushik.bha on 04/09/24.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UIButton *weatherButton;

- (IBAction)getWeather:(id)sender;

@end

