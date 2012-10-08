//
//  NovelaViewController.h
//  Novela2012
//
//  Created by Mélanie Bessagnet on 18/09/12.
//  Copyright (c) 2012 ekito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface NovelaViewController : UIViewController<CLLocationManagerDelegate, UIWebViewDelegate> {
@private
    CLLocationManager *locationManager;
}

@property (nonatomic, retain) IBOutlet UIWebView                *webView;
@property (nonatomic, retain) IBOutlet UIButton                 *locationButton;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView  *activityIndicator;

@property (nonatomic, retain) CLLocationManager                 *locationManager;

- (void)switchToBackgroundMode;

@end
