//
//  NovelaAppDelegate.m
//  Novela2012
//
//  Created by Mélanie Bessagnet on 18/09/12.
//  Copyright (c) 2012 ekito. All rights reserved.
//

#import "NovelaAppDelegate.h"
#import "NovelaViewController.h"
#import "NSString+UUID.h"

@implementation NovelaAppDelegate

@synthesize window;
@synthesize navController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:UUID_USER_DEFAULTS_KEY] == nil) {
        [defaults setObject:[NSString uuid] forKey:UUID_USER_DEFAULTS_KEY];
        [defaults synchronize];
    }

    if ([[UINavigationBar class]respondsToSelector:@selector(appearance)]) {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbar_portrait.png"] forBarMetrics:UIBarMetricsDefault];
        if ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON ) {
            [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbar_landscape-568h.png"] forBarMetrics:UIBarMetricsLandscapePhone];
        } else {
            [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbar_landscape.png"] forBarMetrics:UIBarMetricsLandscapePhone];
        }
    }
    
    [window addSubview:navController.view];
    [window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    NovelaViewController *novelaViewController = (NovelaViewController *)self.navController.visibleViewController;
    [novelaViewController switchToBackgroundMode];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
