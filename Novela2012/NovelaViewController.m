//
//  NovelaViewController.m
//  Novela2012
//
//  Created by Mélanie Bessagnet on 18/09/12.
//  Copyright (c) 2012 ekito. All rights reserved.
//

#import "NovelaViewController.h"
#import "NovelaAboutViewController.h"

@interface NovelaViewController ()
@property (nonatomic) BOOL isFirstCenterLocation;
@property (nonatomic) BOOL isStart;
- (IBAction)startUpdatingLocation:(id)sender;
- (IBAction)centerMap:(id)sender;
- (IBAction)showAboutPage:(id)sender;
@end

@implementation NovelaViewController

@synthesize webView, locationButton;
@synthesize locationManager;
@synthesize isStart;
@synthesize isFirstCenterLocation;
@synthesize activityIndicator;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [defaults objectForKey:UUID_USER_DEFAULTS_KEY];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.purpose = NSLocalizedString(@"LOCATION_PURPOSE", @"");
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/map/%@", BASE_URL, userId]]]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    self.locationManager.delegate = nil;
    self.locationManager = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Action methods
- (IBAction)startUpdatingLocation:(id)sender
{
    if ([[self.locationButton titleForState:UIControlStateNormal] isEqualToString:@"Start"]) {
        isStart = YES;
        [self.locationManager startUpdatingLocation];
        [self.locationButton setTitle:@"Stop" forState:UIControlStateNormal];
    } else if ([[self.locationButton titleForState:UIControlStateNormal] isEqualToString:@"Stop"]) {
        [self.locationManager stopUpdatingLocation];
        [self.locationButton setTitle:@"Start" forState:UIControlStateNormal];
    }
}

// Center map on user location
- (IBAction)centerMap:(id)sender
{
    NovelaWSFacade *sharedWSFacade = [NovelaWSFacade sharedNovelaWSFacade];
    
    if (self.locationManager.location) {
        NovelaLocation *location = [[NovelaLocation alloc] init];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        location.userId = [defaults objectForKey:UUID_USER_DEFAULTS_KEY];
        
        location.latitude = [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.latitude];
        location.longitude = [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.longitude];
    
        location.zoom = @"2";
        
        [sharedWSFacade centerMapOnLocation:location completion:^(BOOL finished) {
            
        }];
    } else {
        isFirstCenterLocation = YES;
        [self.locationManager startUpdatingLocation];
    }
}

- (IBAction)showAboutPage:(id)sender
{
    NovelaAboutViewController *viewController = [[NovelaAboutViewController alloc] initWithNibName:@"NovelaAboutViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)switchToBackgroundMode
{
    [self.locationManager stopUpdatingLocation];
    [self.locationButton setTitle:@"Start" forState:UIControlStateNormal];
}

#pragma mark - CLLocationManagerDelegate methods
// Pre iOS6 - locationManager:didUpdateToLocation:fromLocation:
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (newLocation) {
        if (oldLocation.coordinate.latitude != newLocation.coordinate.latitude && oldLocation.coordinate.longitude != newLocation.coordinate.longitude) {
            if (newLocation.horizontalAccuracy < 100) {
                NSDate *eventDate = newLocation.timestamp;
                NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
                NSLog(@"didUpdate recent %f - accuracy %f", howRecent, newLocation.horizontalAccuracy);
                if (abs(howRecent) < 15.0) {
                    if (isFirstCenterLocation) {
                        NSLog(@"First Time Location Update from centerMap");
                        
                        [self centerMap:nil];
                        isFirstCenterLocation = NO;
                    } else {
                        // Send coordinates
                        NSLog(@"Send coordinates <%f,%f>", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
                        
                        NovelaWSFacade *sharedWSFacade = [NovelaWSFacade sharedNovelaWSFacade];
                        
                        NovelaLocation *location = [[NovelaLocation alloc] init];
                        
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        location.userId = [defaults objectForKey:UUID_USER_DEFAULTS_KEY];
                        
                        location.latitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
                        location.longitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
                        
                        location.isStart = isStart;
                        
                        [sharedWSFacade addLocation:location completion:^(BOOL finished) {
                            
                        }];
                        
                        if (isStart) {
                            isStart = NO;
                        }
                    }
                }
            }
        }
    }
}

// iOS 6 - locationManager:didUpdateLocations
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
    if (newLocation) {
        if (newLocation.horizontalAccuracy < 100) {
            NSDate *eventDate = newLocation.timestamp;
            NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
            NSLog(@"didUpdate recent %f - accuracy %f", howRecent, newLocation.horizontalAccuracy);
            if (abs(howRecent) < 15.0) {
                if (isFirstCenterLocation) {
                    NSLog(@"First Time Location Update from centerMap");
                    
                    [self centerMap:nil];
                    isFirstCenterLocation = NO;
                } else {
                    NSLog(@"Send coordinates <%f,%f>", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
                    // Send coordinates
                    NovelaWSFacade *sharedWSFacade = [NovelaWSFacade sharedNovelaWSFacade];
                    
                    NovelaLocation *location = [[NovelaLocation alloc] init];
                    
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    location.userId = [defaults objectForKey:UUID_USER_DEFAULTS_KEY];
                    
                    location.latitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
                    location.longitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
                    
                    location.isStart = isStart;
                    
                    [sharedWSFacade addLocation:location completion:^(BOOL finished) {
                        
                    }];
                    
                    if (isStart) {
                        isStart = NO;
                    }
                }
            }
        }
    }
}

#pragma mark - UIWebViewDelegate methods
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityIndicator startAnimating];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.activityIndicator stopAnimating];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

@end
