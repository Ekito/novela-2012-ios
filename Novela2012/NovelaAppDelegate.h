//
//  NovelaAppDelegate.h
//  Novela2012
//
//  Created by Mélanie Bessagnet on 18/09/12.
//  Copyright (c) 2012 ekito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NovelaAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow                *window;
    UINavigationController  *navController;
}

@property (strong, nonatomic) IBOutlet UIWindow                 *window;
@property (strong, nonatomic) IBOutlet UINavigationController   *navController;

@end
