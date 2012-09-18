//
//  NovelaViewController.m
//  Novela2012
//
//  Created by Mélanie Bessagnet on 18/09/12.
//  Copyright (c) 2012 ekito. All rights reserved.
//

#import "NovelaViewController.h"

@interface NovelaViewController ()

@end

@implementation NovelaViewController

@synthesize webView, locationButton;
@synthesize locationManager;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
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
        [self.locationManager startUpdatingLocation];
        [self.locationButton setTitle:@"Stop" forState:UIControlStateNormal];
    } else if ([[self.locationButton titleForState:UIControlStateNormal] isEqualToString:@"Stop"]) {
        [self.locationManager stopUpdatingLocation];
        [self.locationButton setTitle:@"Start" forState:UIControlStateNormal];
    }
}

- (void)switchToBackgroundMode
{
    [self.locationManager stopUpdatingLocation];
    [self.locationButton setTitle:@"Start" forState:UIControlStateNormal];
}

#pragma mark - CLLocationManagerDelegate methods
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (newLocation) {
        if (oldLocation.coordinate.latitude != newLocation.coordinate.latitude && oldLocation.coordinate.longitude != newLocation.coordinate.longitude) {
            if (newLocation.horizontalAccuracy < 100) {
                // Send coordinates
            }
        }
    }
}

@end
